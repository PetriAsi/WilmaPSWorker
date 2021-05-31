function Invoke-WPSWPrimusQuery  {
    param (
    # Queryname on primus
    [Parameter(Mandatory=$true, Position = 0)]
    [string]
    $QueryName,

    #Write output to file
    [Parameter(Mandatory=$false,ParameterSetName="Query")]
    [string]$Outfile,

    #Parse results and return as parsed psobjects
    [Parameter(Mandatory=$true,ParameterSetName="Format")]
    [ValidateSet('xml','csv')]
    [string]$ParseResults,

    #CSV delimiter
    [Parameter(Mandatory=$false,ParameterSetName="Format")]
    [string]$Delimiter=';',

    #Column names for csv file
    [Parameter(Mandatory=$false,ParameterSetName="Format")]
    [string[]]$Header,

    #Parameters for primusquery, supports also arrays.
    #In primusquery you can use %p1% , %p2% ... for multiple parameters
    [Parameter(Mandatory=$false,ParameterSetName="Query")]
    [Parameter(Mandatory=$false,ParameterSetName="Format")]
    [string[]]$Parameters,



    #File to import to primus
    [Parameter(Mandatory=$true,ParameterSetName="Import")]
    [string]$Infile

    )

    $WPSWSession = Get-WPSWCurrentSession

    $pwdfile = Get-CredFile $WPSWSession.config.pq_cred

    $pq = $WPSWSession.config.pq_exe

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

    $callparms += $($WPSWSession.config.pq_host)
    $callparms += $($WPSWSession.config.pq_port)
    $callparms += $($WPSWSession.config.pq_cred.UserName)
    $callparms += "`"file:$pwdfile`""
    $callparms += $QueryName

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
