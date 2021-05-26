function Get-WPWSSite(){
    param(
        [string]$site
    )
    $config = Get-WPSWConfig
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
