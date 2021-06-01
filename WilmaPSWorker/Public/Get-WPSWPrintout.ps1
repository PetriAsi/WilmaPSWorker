<#
.SYNOPSIS
Get  pdf printout from wilma.
.Description
Downloads genarated pdf:s from Wilma.
#>
function Get-WPSWPrintout (){
    [CmdletBinding()]
    param(
      # Database
      [Parameter(Mandatory=$true)]
      [validateSet('student','explearning','skilldemo','explearningplaces','crediting','decisions','instructors','applicants','courses')]
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
      student = 'skip'
      explearning = 12
      explearningplaces = 7
      skilldemo = 11
      crediting = 33
      decisions = 'skip'
      instructors = 4
      applicants  = 9
      courses  = 13


    }

    $bid=$database_ids[$Database]
    $WPSWSession = Get-WPSWCurrentSession
    $basepath="/printouts/"

    if ( $Database -eq 'student') {
      $entid = 'sid'
    } else {
      $entid = 'gid'
    }

    try {
      $url = "$($WPSWSession.config.url)$basepath$($print_id).pdf?$(if($bid -ne 'skip'){"bid=$bid&"})$entid=$card_id)"
      Write-Verbose "$url $($OutFile)"
      $result = Invoke-WebRequest -Method Get -Uri $url -WebSession $WPSWSession.WilmaSession -OutFile $OutFile
      if($result.Statuscode -ne 200){
        Write-Warning "Problem generating printout. Statuscode $($result.Statuscode) "
      }
    }
    catch{
      Write-Error "Could get printout."
    }

}
