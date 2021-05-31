<#
.SYNOPSIS
Get student photo
#>
function Get-WPSWStudentPhoto (){
    [CmdletBinding()]
    param(
      #Student ID
      [Parameter(Mandatory=$true)]
      [int]
      $student_id,
      #Output file
      [Parameter(Mandatory=$true)]
      [string]
      $OutFile
    )
    $WPSWSession = Get-WPSWCurrentSession
    try {
      Write-Verbose "$($WPSWSession.config.url)/profiles/photo/student/$($student_id) $($OutFile)"
      Invoke-WebRequest -Method Get -Uri "$($WPSWSession.config.url)/profiles/photo/student/$($student_id)" -WebSession $WPSWSession.WilmaSession -OutFile $OutFile
    }
    catch{
      Write-Error "Could get student photo for id $student_id."
    }

}
