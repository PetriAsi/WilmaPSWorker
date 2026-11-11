<#
.Synopsis
Returns request headers for current session, refreshes tokens when needed

.Description
With token authentication adds Authorization Bearer header. With legacy session cookie
authentication returns given headers as is.
#>
function Get-WPSWRequestHeader (){
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [hashtable]
    $Session,

    # Additional headers
    [hashtable]
    $Headers = @{}
  )
  process {
    Update-WPSWToken -Session $Session

    $result = $Headers.Clone()
    if ($Session.Auth.Mode -eq 'Token') {
      $result['Authorization'] = "Bearer $($Session.Auth.AccessToken)"
    }
    $result
  }
}
