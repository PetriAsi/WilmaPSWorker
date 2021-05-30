function Get-CredFile(){
    param(
        [parameter(Mandatory=$true)]
        [pscredential]
        $cred
    )
    $pwdfile = [System.IO.Path]::GetTempFileName()
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($config.Credential.password)
    $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    $UnsecurePassword |Out-File -encoding utf8 $pwdfile
    $pwdfile
}
