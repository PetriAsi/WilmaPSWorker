function Invoke-WPSWPrimusQuery  {
    param (
    # Queryname on primus
    [Parameter(Mandatory=$true, Position = 0)]
    [string]
    $QueryName,

    #Parameters for primusquery, supports also arrays
    [Parameter(Mandatory=$false)]
    [string[]]$Parameters,

    #Write output to file
    [Parameter(Mandatory=$false)]
    [string]$Outfile
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

    if($Outfile){
      $callparms += '-o'
      $callparms += $Outfile
    }

    $callparms += $($WPSWSession.config.pq_host)
    $callparms += $($WPSWSession.config.pq_port)
    $callparms += $($WPSWSession.config.pq_cred.UserName)
    $callparms += "`"file:$pwdfile`""
    $callparms += $QueryName

    &$pq  $callparms

    Remove-TempFile -tmpfile $pwdfile


  }
