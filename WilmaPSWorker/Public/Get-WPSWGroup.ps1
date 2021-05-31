<#
.SYNOPSIS
Get messages
#>
function Get-WPSWGroup (){
    [CmdletBinding()]
    param(
    )
    $WPSWSession = Get-WPSWCurrentSession
    $target = '/groups/index_json'
    try {
      Write-Verbose "$($WPSWSession.config.url)$($target) $($OutFile)"
      $result = Invoke-WebRequest -Method Get -Uri "$($WPSWSession.config.url)$($target)" -WebSession $WPSWSession.WilmaSession
      if($result.Statuscode -eq 200) {
        $result.Content
      } else {
        Write-Error "Get-WPSWGroup unexpected statuscode $($result.Statuscode)"
      }
    }
    catch{
      Write-Error "Could get groups."
    }

}
