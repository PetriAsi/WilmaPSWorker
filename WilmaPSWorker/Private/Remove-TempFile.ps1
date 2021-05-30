function Remove-TempFile {
    param (
    [Parameter(Mandatory=$true)]
    [string]$tmpfile
    )
    if((get-item $tmpfile).Length -le 52 -and (get-item $tmpfile).Length -gt 0 ) {
    $rs = -join ((65..90) + (97..122) | Get-Random -Count (get-item $tmpfile).Length | ForEach-Object {[char]$_})
    Set-Content -Path $tmpfile $rs
    } else {
    Clear-Content -Path $tmpfile
    }

    Remove-Item $tmpfile
  }
