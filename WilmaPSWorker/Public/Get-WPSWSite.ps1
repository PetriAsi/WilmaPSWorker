<#
.Synopsis
Gets all Wilma site settings or specific site settings
#>
function Get-WPSWSite(){
    param(
        [string]$site
    )
    $config = Get-WPSWConfig -all
    if($config.sites) {
        If(! $site ) {
            $config.sites
        } else {
            if ($config.sites.ContainsKey($site)) {
                $config.sites[$site]
            }else{
                Write-Error "Site `"$site`" not found"
            }
        }
    } else {
        Write-Warning "No Wilma sites defined. Please add one with New-WPSWSite"
    }
}
