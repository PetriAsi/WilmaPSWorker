function Get-WPSWConfig(){
    param(
        [string]
        $server = 'DEFAULT',
        [switch]
        $all = $false
    )
    $config = Import-Configuration
    if(! $all){
        #just one server return it
        if($config.sites.Keys.Count -eq 1){
            $config = $config.sites[$config.sites.Keys[0]]
        } else {
            if($server -eq 'DEFAULT'){
                $server = $config.default
            }
            if($config.sites.ContainsKey($server)) {
                $config.sites[$server]
            } else {
                Throw "Server $server not found"
            }

        }

    } else {
        return $config
    }
}
