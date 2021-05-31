<#
.SYNOPSIS
Get pdf printout from generic databases
#>
function Get-WPSWPrintout (){
    [CmdletBinding()]
    param(
      # Database
      [Parameter(Mandatory=$true)]
      [validateSet('explearning','','explearningplaces')]
      [string]
      $Database,

      # card ID
      [Parameter(Mandatory=$true)]
      [int]
      $card_id,
      # Output file
      [Parameter(Mandatory=$true)]
      [string]
      $OutFile

    )
    $database_ids = @{
      explearning = 12
      explearningplaces = 7
      skilldemo = 11
    }

    $bid=$database_ids[$Database]
    $WPSWSession = Get-WPSWCurrentSession
    $basepath="/printouts/"
    try {
      Write-Verbose "$($WPSWSession.config.url)$basepath$($print_id).pdf?bid=$bid&gid=$card_id $($OutFile)"
      $result = Invoke-WebRequest -Method Get -Uri "$($WPSWSession.config.url)$basepath$($print_id).pdf?bid=$bid&gid=$card_id" -WebSession $WPSWSession.WilmaSession -OutFile $OutFile
      if($result.Statuscode -ne 200){
        Write-Warning "Problem generating printout. Statuscode $($result.Statuscode) "
      }
    }
    catch{
      Write-Error "Could get printout."
    }

}
