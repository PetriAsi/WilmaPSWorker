<#
.Synopsis
Builds SHA1 string for wilma login
#>
Function Get-SHA1StringHash() {
    [CmdletBinding()]
    param(

        [Parameter(Mandatory=$true)]
        [string]
        $String
    )

    # Create Input Data
    $enc      = [system.Text.Encoding]::UTF8
    $data     = $enc.GetBytes($string)
    # Create a New SHA1 Crypto Provider
    $sha1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
    # Now hash
    $ResultHash = $sha1.ComputeHash($data)
    # To return string
    $StringBuilder = New-Object System.Text.StringBuilder
    $ResultHash|ForEach-Object{ [Void]$StringBuilder.Append($_.ToString("x2")) }
    $StringBuilder.tostring()
}
