<#
.Synopsis
Gets modules configuration, sites and other settings.
#>
function Get-WPSWConfig(){
    [CmdletBinding()]
    param(
        [string]
        $site = 'DEFAULT',
        [switch]
        $all = $false
    )

    Write-Verbose "Get-WPSWConfig"
    Write-Debug "Site : $server all: $all"
    $config = Import-Configuration

    Write-Verbose "Got config"
    Write-Debug "config: $config"

    if(! $all){
        if($config.sites.Keys.Count -eq 1){
            Write-Verbose "just one site, return it"
            $config.sites[$config.sites.Keys[0]]
        } else {
            if($site -eq 'DEFAULT'){
                $site = $config.default
                Write-Verbose "selected DEFAULT server: $server"
            }
            if($config.sites.ContainsKey($server)) {
                $config.sites[$site]
            } else {
                Throw "Site $site not found"
            }

        }

    } else {
        return $config
    }
}
