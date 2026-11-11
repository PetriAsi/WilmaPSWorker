<#
.Synopsis
Refreshes access token before it expires, or logs in again if tokens are not usable

.Description
Does nothing for sessions using the legacy session cookie. Session hashtable is updated in place.
#>
function Update-WPSWToken (){
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [hashtable]
    $Session,

    # Seconds before expiration when token is refreshed
    [int]
    $Margin = 60
  )
  process {
    if ($Session.Auth.Mode -ne 'Token') {
      return
    }

    $auth = $Session.Auth
    $remaining = ($auth.ExpiresAt - [DateTime]::UtcNow).TotalSeconds

    if ($remaining -gt $Margin) {
      return
    }

    # Expired access token would invalidate the whole session, so do not send it
    if ($remaining -gt 0) {
      try {
        Write-Verbose "Update-WPSWToken refreshing access token"
        $reply = Invoke-RestMethod -Method Post -Uri "$($auth.Issuer.TrimEnd('/'))/api/v1/token" `
          -ContentType 'application/x-www-form-urlencoded' `
          -Body @{ grant_type = 'refresh_token'; refresh_token = $auth.RefreshToken }

        $auth.AccessToken = $reply.access_token
        $auth.RefreshToken = $reply.refresh_token
        $auth.ExpiresAt = [DateTime]::UtcNow.AddSeconds([int]$reply.expires_in)
        try {
          $iss = (ConvertFrom-WPSWJwt -Token $reply.access_token).iss
          if ($iss) { $auth.Issuer = $iss }
        } catch {
          Write-Debug "Update-WPSWToken could not decode refreshed token"
        }
        return
      }
      catch {
        Write-Verbose "Update-WPSWToken refresh failed: $($_.Exception.Message)"
      }
    }

    Write-Verbose "Update-WPSWToken logging in again"
    $newSession = New-WPSWSession -site $Session.Site
    foreach ($key in $newSession.Keys) {
      $Session[$key] = $newSession[$key]
    }
  }
}
