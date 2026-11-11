<#
.Synopsis
Decodes JWT payload without validating the signature
#>
function ConvertFrom-WPSWJwt (){
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [string]
    $Token
  )
  process {
    $parts = $Token.Split('.')
    if ($parts.Count -lt 2) {
      throw "ConvertFrom-WPSWJwt: not a JWT"
    }

    $payload = $parts[1].Replace('-', '+').Replace('_', '/')
    switch ($payload.Length % 4) {
      2 { $payload += '==' }
      3 { $payload += '=' }
    }

    [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($payload)) | ConvertFrom-Json
  }
}
