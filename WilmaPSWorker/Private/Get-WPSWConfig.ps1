function Get-WPSWConfig(){
    [CmdletBinding()]
    param(
        [string]
        $server = 'DEFAULT',
        [switch]
        $all = $false
    )

    Write-Verbose "Get-WPSWConfig"
    Write-Debug "server : $server all: $all"
    $config = Import-Configuration

    Write-Verbose "Got config"
    Write-Debug "config: $config"

    if(! $all){
        if($config.sites.Keys.Count -eq 1){
            Write-Verbose "just one server, return it"
            $config.sites[$config.sites.Keys[0]]
        } else {
            if($server -eq 'DEFAULT'){
                $server = $config.default
                Write-Verbose "selected DEFAULT server: $server"
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
