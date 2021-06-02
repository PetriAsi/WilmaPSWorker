<#
.SYNOPSIS
Get pdf printout from wilma.
.Description
Downloads genarated pdf:s from Wilma.

.EXAMPLE
Get-WPSWPrintout -Database explearning -card_id 23656  -print_id 86 -OutFile c:\temp\test.pdf

Gets prinout pdf for explearning id 23656 using printsettings 86
#>
function Get-WPSWPrintout (){
    [CmdletBinding()]
    param(
      # Database
      [Parameter(Mandatory=$true)]
      [validateSet('student','explearning','skilldemo','explearningplaces','crediting','decisions','instructors','applicants','courses')]
      [string]
      $Database,

      # Print ID
      # Ypu can get this with browser, it's number part of generated pdf.
      [Parameter(Mandatory=$true)]
      [int]
      $print_id,
      # card ID
      [Parameter(Mandatory=$true)]
      [int]
      $card_id,
      # Output file
      [Parameter(Mandatory=$true)]
      [string]
      $OutFile

    )
    begin {
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
  }
  process{
    try {
      $url = "$($WPSWSession.config.url)$basepath$($print_id).pdf?$(if($bid -ne 'skip'){"bid=$bid&"})$entid=$card_id"
      Write-Verbose "$url $($OutFile)"
      $result = Invoke-RestMethod -Method Get -Uri $url -WebSession ($WPSWSession.WilmaSession) -OutFile $OutFile

    }
    catch{
      $ErrorMessage = $_.Exception.Message
      Write-Error "Could not get printout. result: $result. Error message: $ErrorMessage"
    }
  }
}
