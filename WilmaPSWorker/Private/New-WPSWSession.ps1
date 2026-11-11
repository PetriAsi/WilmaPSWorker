<#
.Synopsis
Connects to Wilma and sets session variables
#>
function New-WPSWSession (){
    [CmdletBinding()]
    param(
      [string]
      $site = 'DEFAULT'
    )
    begin {
    $config = Get-WPSWConfig -site $site

    Write-Verbose "Starting Get-WPSWSession"
    Write-Debug "Config: $config"

    $Login = $config.cred.UserName
    $password =  [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($config.cred.Password))

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $reply = Invoke-RestMethod -Uri "$($config.url)/index_json"
    $SessionId=$reply.SessionID
    }
    process {
      try{
      $data= "$Login|$SessionId|$($config.apikey)"
      $hashString= Get-SHA1stringHash( $data )
      $Apikey = "sha1:$hashString"

      $LoginParameters = @{
        Login = $Login
        Password = $Password
        SessionId = $SessionID
        ApiKey = $Apikey
        format = 'json'
      }

      $reply = Invoke-RestMethod -Method Post -Uri "$($config.url)/login" -Form $LoginParameters -SessionVariable WilmaSession -ResponseHeadersVariable LoginHeaders

      $result = @{
          LoginResult = $reply.LoginResult
          WilmaId     = $reply.WilmaId
          ApiVersion  = $reply.ApiVersion
          FormKey     = $reply.FormKey
          ConnectIds  = $reply.ConnectIds
          Slug        = $reply.Slug
          Name        = $reply.Name
          Type        = $reply.Type
          PrimusId    = $reply.PrimusId
          School      = $reply.School
      }

      if ($result.LoginResult -ne "OK") {
        Write-Debug $result
        Throw "Kirjautuminen epäonnistui"
      } else {
        # Token cookies present means the site uses token authentication, otherwise legacy session cookie
        $cookies = @{}
        foreach ($cookie in $WilmaSession.Cookies.GetCookies([uri]$config.url)) {
          $cookies[$cookie.Name] = $cookie.Value
        }
        foreach ($header in @($LoginHeaders['Set-Cookie'])) {
          if ($header -match '^(__Host-Wilma2(?:AT|RT))=([^;]+)') {
            $cookies[$Matches[1]] = $Matches[2]
          }
        }

        $auth = @{ Mode = 'Cookie' }
        if ($cookies['__Host-Wilma2AT'] -and $cookies['__Host-Wilma2RT']) {
          $jwt = ConvertFrom-WPSWJwt -Token $cookies['__Host-Wilma2AT']
          $auth = @{
            Mode         = 'Token'
            AccessToken  = $cookies['__Host-Wilma2AT']
            RefreshToken = $cookies['__Host-Wilma2RT']
            ExpiresAt    = [DateTimeOffset]::FromUnixTimeSeconds([long]$jwt.exp).UtcDateTime
            Issuer       = $jwt.iss
          }
        }
        Write-Verbose "Authentication mode: $($auth.Mode)"

        @{WilmaSession=$WilmaSession
          Result = $result
          config = $config
          Site   = $site
          Auth   = $auth}
      }
    }
    catch {
      $ErrorMessage = $_.Exception.Message
      throw{"New-WPSWSession cannot connect to site: $ErrorMessage"}
    }
  }
}
