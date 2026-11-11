BeforeAll {
  $moduleRoot = Join-Path (Split-Path -Parent $PSScriptRoot) 'WilmaPSWorker'
  Import-Module (Join-Path $moduleRoot 'WilmaPSWorker.psd1') -Force
}

Describe 'Token authentication' {
  Context 'ConvertFrom-WPSWJwt' {
    It 'Decodes base64url payload' {
      InModuleScope WilmaPSWorker {
        $payload = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('{"exp":1234567890,"iss":"https://auth.example/?>>"}')).TrimEnd('=').Replace('+', '-').Replace('/', '_')
        $jwt = ConvertFrom-WPSWJwt -Token "h.$payload.s"
        $jwt.exp | Should -Be 1234567890
        $jwt.iss | Should -Be 'https://auth.example/?>>'
      }
    }
  }

  Context 'Get-WPSWRequestHeader' {
    It 'Returns given headers for cookie sessions' {
      InModuleScope WilmaPSWorker {
        $session = @{ Auth = @{ Mode = 'Cookie' } }
        $headers = Get-WPSWRequestHeader -Session $session -Headers @{ dnt = 1 }
        $headers.dnt | Should -Be 1
        $headers.ContainsKey('Authorization') | Should -BeFalse
      }
    }

    It 'Adds Bearer header for token sessions' {
      InModuleScope WilmaPSWorker {
        $session = @{ Auth = @{ Mode = 'Token'; AccessToken = 'abc'; RefreshToken = 'r'; Issuer = 'https://auth.example'; ExpiresAt = [DateTime]::UtcNow.AddMinutes(10) } }
        $headers = Get-WPSWRequestHeader -Session $session -Headers @{ dnt = 1 }
        $headers.Authorization | Should -Be 'Bearer abc'
        $headers.dnt | Should -Be 1
      }
    }
  }

  Context 'Update-WPSWToken' {
    It 'Does not refresh a token that is still valid' {
      InModuleScope WilmaPSWorker {
        Mock Invoke-RestMethod {}
        Mock New-WPSWSession {}
        $session = @{ Auth = @{ Mode = 'Token'; AccessToken = 'abc'; RefreshToken = 'r'; Issuer = 'https://auth.example'; ExpiresAt = [DateTime]::UtcNow.AddMinutes(10) } }
        Update-WPSWToken -Session $session
        Should -Invoke Invoke-RestMethod -Times 0
        Should -Invoke New-WPSWSession -Times 0
      }
    }

    It 'Refreshes token close to expiration and stores both new tokens' {
      InModuleScope WilmaPSWorker {
        Mock Invoke-RestMethod { @{ access_token = 'new-at'; refresh_token = 'new-rt'; expires_in = 300 } }
        Mock New-WPSWSession {}
        $session = @{ Auth = @{ Mode = 'Token'; AccessToken = 'abc'; RefreshToken = 'old-rt'; Issuer = 'https://auth.example/'; ExpiresAt = [DateTime]::UtcNow.AddSeconds(20) } }
        Update-WPSWToken -Session $session
        Should -Invoke Invoke-RestMethod -Times 1 -ParameterFilter {
          $Uri -eq 'https://auth.example/api/v1/token' -and $Method -eq 'Post' -and
          $Body.grant_type -eq 'refresh_token' -and $Body.refresh_token -eq 'old-rt'
        }
        $session.Auth.AccessToken | Should -Be 'new-at'
        $session.Auth.RefreshToken | Should -Be 'new-rt'
        $session.Auth.ExpiresAt | Should -BeGreaterThan ([DateTime]::UtcNow.AddSeconds(250))
        Should -Invoke New-WPSWSession -Times 0
      }
    }

    It 'Logs in again when refresh fails' {
      InModuleScope WilmaPSWorker {
        Mock Invoke-RestMethod { throw 'refresh failed' }
        Mock New-WPSWSession { @{ Site = 'x'; Auth = @{ Mode = 'Token'; AccessToken = 'fresh' } } }
        $session = @{ Site = 'x'; Auth = @{ Mode = 'Token'; AccessToken = 'abc'; RefreshToken = 'r'; Issuer = 'https://auth.example'; ExpiresAt = [DateTime]::UtcNow.AddSeconds(20) } }
        Update-WPSWToken -Session $session
        Should -Invoke New-WPSWSession -Times 1
        $session.Auth.AccessToken | Should -Be 'fresh'
      }
    }

    It 'Logs in again without sending an already expired token' {
      InModuleScope WilmaPSWorker {
        Mock Invoke-RestMethod {}
        Mock New-WPSWSession { @{ Site = 'x'; Auth = @{ Mode = 'Token'; AccessToken = 'fresh' } } }
        $session = @{ Site = 'x'; Auth = @{ Mode = 'Token'; AccessToken = 'abc'; RefreshToken = 'r'; Issuer = 'https://auth.example'; ExpiresAt = [DateTime]::UtcNow.AddSeconds(-5) } }
        Update-WPSWToken -Session $session
        Should -Invoke Invoke-RestMethod -Times 0
        Should -Invoke New-WPSWSession -Times 1
      }
    }
  }
}
