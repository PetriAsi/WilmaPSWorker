<#
.Synopsis
Converts credential to tmpfile
#>
function Get-CredFile(){
    [CmdletBinding()]
    param(
        [parameter(Mandatory=$true)]
        [pscredential]
        $cred
    )
    $pwdfile = [System.IO.Path]::GetTempFileName()
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($cred.Password)
    $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)
    $UnsecurePassword |Out-File  -NoNewline -encoding utf8NoBOM $pwdfile
    $pwdfile
}
