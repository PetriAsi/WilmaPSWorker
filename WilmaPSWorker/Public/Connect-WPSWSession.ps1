<#
.SYNOPSIS
Connects to wilma site and  selects primusquery credentials

.DESCRIPTION
Connect to wilma site, establish websession and selects primusquery credentials to use.

.EXAMPLE
Connect-WPSWSession

Connects to default site

.EXAMPLE
Connect-WPSWSession -site "testsite"

Connects to named site
#>
function Connect-WPSWSession (){
    [CmdletBinding()]
    param(
      #Server name, set with New-WPSWSite and Set-WPSWSite
      [string]
      $site = 'DEFAULT'
    )

    try {
      Write-Verbose "Calling New-WPSWSession -site $site"
      $WPSWSession = New-WPSWSession -site $site
      Write-Debug "Login result: $($WPSWSession.Result.LoginResult)"
      Set-Variable -Name '_WPSWSession' -Value $WPSWSession -Scope Script -Force

    }
    Catch {
      Throw "Could not connect session to $site"
    }

}
