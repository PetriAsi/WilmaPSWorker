<#
.SYNOPSIS
Get current WPSWSession settings

.EXAMPLE
Get-WPSWCurrentSession

#>
function Get-WPSWCurrentSession (){
    [CmdletBinding()]
    param()
    begin {
      try {
        Write-Verbose "Get-WPSWCurrentSession -Begin"
        $WPSWSession = Get-Variable -Name '_WPSWSession' -Scope Script
      }
      Catch {
        Throw "Cannot get Current WPSWSession. have you set up your site settings with New-WPSWSite and Connect-WPSWSession"
      }
    }
    process {
      $WPSWSession.Value
    }
}
