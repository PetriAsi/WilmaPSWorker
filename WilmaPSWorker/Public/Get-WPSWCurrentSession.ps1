<#
.SYNOPSIS
Get current WPSWSession
#>
function Get-WPSWCurrentSession (){
    [CmdletBinding()]
    param()
    try {
      Write-Verbose "GEt-WPSWCurrentSession"
      $WPSWSession = $PsCmdlet.SessionState.PSVariable.Get("_WPSWSession")
      $WPSWSession.Value
    }
    Catch {
      Throw "Cannot get Current WPSWSession. have you set up your site settings with New-WPSWSite and Connect-WPSWSession"
    }

}
