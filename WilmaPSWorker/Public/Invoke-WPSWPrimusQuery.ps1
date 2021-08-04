<#
.Synopsis
Invokes primusquery, exports and imports data from Primus.

.Description
Invokes primusquery, exports and imports data from Primus. Exported data can be saved
to file or processes as XML or CSV formating.

.EXAMPLE
Invoke-WPSWPrimusQuery -QueryName students -Outfile students.txt

Saves primusquery output to student.txt

.EXAMPLE
Invoke-WPSWPrimusQuery -QueryName classes -ParseResults csv -Delimiter '|'

Invokes query, parses results as csv and returns result lines as powershell objects

.EXAMPLE
Invoke-WPSWPrimusQuery -QueryName applicants -ParseResults xml -Parameters "3.4.2021"

Invokes query with parameters to get applicants, parses results as xml and returns result as xml object

.EXAMPLE
Invoke-WPSWPrimusQuery -QueryName Grades -Infile new-grades

Imports data to primus

#>
function Invoke-WPSWPrimusQuery  {
  [CmdletBinding()]
  param (

    # Site to query
    [string]
    $site = 'DEFAULT',

    # Queryname on primus
    [Parameter(Mandatory=$true, Position = 0)]
    [string]
    $QueryName,

    #Write output to file
    [Parameter(Mandatory=$false,ParameterSetName="Basic query")]
    [string]$Outfile,

    #Parse results and return as parsed psobjects
    [Parameter(Mandatory=$true,ParameterSetName="Format results")]
    [ValidateSet('xml','csv')]
    [string]$ParseResults,

    #CSV delimiter
    [Parameter(Mandatory=$false,ParameterSetName="Format results")]
    [string]$Delimiter=';',

    #Column names for csv file
    [Parameter(Mandatory=$false,ParameterSetName="Format results")]
    [string[]]$Header,

    #Parameters for primusquery, supports also arrays.
    #In primusquery you can use %p1% , %p2% ... for multiple parameters
    [Parameter(Mandatory=$false,ParameterSetName="Basic query")]
    [Parameter(Mandatory=$false,ParameterSetName="Format results")]
    [string[]]$Parameters,

    #File to import to primus
    [Parameter(Mandatory=$true,ParameterSetName="Import data")]
    [string]$Infile

  )
  begin {
    $config = Get-WPSWConfig -site $site
    Write-Verbose "Invoke-WPSWPrimusquery - config $($config | ConvertTo-Json)"

    if ($null -ne $config.pq_cred) {
      $pwdfile = Get-CredFile $config.pq_cred
    } else {
      throw "Invoke-WPSWPrimusquery - Could not find current credentials!"
    }


    if ($null -ne $config.pq_exe ) {
      $pq = $config.pq_exe
      if (-not (Test-Path $pq)) {
        throw "Invoke-WPSWPrimusquery - Could not primusquery path: $pq"
      }
    } else {
      throw "Invoke-WPSWPrimusquery - Could not find pq_exe variable!"
    }

    #quiet and continue on errors
    $callparms = @('-f', '-q')

    foreach( $cp in $Parameters){
        $callparms += '-p'
        $callparms += $cp
    }

    #We need outputfile to parse results
    if ($ParseResults){
      $outtmp = [System.IO.Path]::GetTempFileName()
      $Outfile = $outtmp
    }

    if($Outfile){
      $callparms += '-o'
      $callparms += $Outfile
    }

    if($Infile){
      $callparms += '-i'
      $callparms += $Infile
    }

    $callparms += $($config.pq_host)
    $callparms += $($config.pq_port)
    $callparms += $($config.pq_cred.UserName)
    $callparms += "`"file:$pwdfile`""
    $callparms += $QueryName

  }

  process {

    #Execute query
    &$pq  $callparms
    #&EchoArgs.exe $callparms

    if($ParseResults){
      switch ($ParseResults){
        'xml' {
          Write-Verbose "Parsing xml..."
          $parsed = new-object Xml
          $ft = get-item $Outfile -ErrorAction SilentlyContinue
          if ($ft.Length -ne 0 ) {
            try  {
              $parsed.load($Outfile)
            }
            catch {
              $ErrorMessage = $_.Exception.Message
              Write-host "Error when trying to parse query results $OutFile to xml:`r$ErrorMessage"
            }
          }
        }
        'csv' {
          Write-Verbose "Parsing csv..."
          Write-Debug "Header: $header"
          Write-Debug "Delimiter: $Delimiter"

          $csvparms = @{
            Path = $OutFile
            Encoding = 'utf8'
          }
          if($Header){
            $csvparms['Header'] = $Header
          }
          if($Delimiter){
            $csvparms['Delimiter'] = $Delimiter
          }
          try{
            $parsed = Import-Csv @csvparms
          }
          catch {
            $ErrorMessage = $_.Exception.Message
            Write-host "Error when trying to parse query results $OutFile to csv:`r$ErrorMessage"
          }
        }
      }
      #Return parsed results
      $parsed
    }
    Remove-TempFile -tmpfile $pwdfile

    if($outtmp) {
      Remove-TempFile -tmpfile $outtmp
    }
  }
}
