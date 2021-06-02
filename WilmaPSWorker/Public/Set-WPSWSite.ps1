<#
.Synopsis
Set site settings
.Description
Changes site defination, urls , hostnames or credentials used to connect Wilma or Primus

.EXAMPLE
Set-WPSWSite -site MyWilma -wilma_cred (get-Credential -message "Wilma credentials")

Changes wilma credentials
.EXAMPLE
Set-WPSWSite -site MyWilma -pq_host primus.server.fi -pq_port 1222 -pq_cred (get-credential -Message "Primus credentials") -pq_exe "c:\Primusquery\primusquery.exe"

Adds or updates primusquery setting on specific site
#>function Set-WPSWSite(){
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # Short name for wilma site
        [Parameter(Mandatory=$true)]
        [string]
        $site,

        # Wilma site url
        [Parameter(ParameterSetName = "Wilma")]
        [string]
        $wilma_url,

        # Wilma api-key
        [Parameter(ParameterSetName = "Wilma")]
        [string]
        $wilma_apikey,

        # Wilma usercredential
        [Parameter(ParameterSetName = "Wilma")]
        [PSCredential]
        $wilma_cred,


         # Primusquery host
         [Parameter(ParameterSetName = "PQ")]
         [string]
         $pq_host,

         # Primusquery port
         [string]
         $pq_port,

         # Creadential to use with primusquery
         [Parameter(ParameterSetName = "PQ")]

         [PSCredential]
         $pq_cred,

         # Path to primusquery excutable
         [Parameter(ParameterSetName = "PQ")]
         [string]
         $pq_exe,

        # set Site as default
        [switch]
        $DefaultSite
        )


        $config = Get-WPSWConfig -all



        if(! $config.sites[$site]) {
            Write-Error "Site $site does not exists."
        } else {
            if ($wilma_url) { $config.sites[$site].url = $wilma_url}
            if ($wilma_apikey) { $config.sites[$site].apikey = $wilma_apikey}
            if ($wilma_cred) { $config.sites[$site].cred = $wilma_cred}

            if ($pq_host) { $config.sites[$site].pq_host = $pq_host}
            if ($pq_port) { $config.sites[$site].pq_port = $pq_port}
            if ($pq_cred) { $config.sites[$site].pq_cred = $pq_cred}
            if ($pq_exe) { $config.sites[$site].pq_exe = $pq_exe}

            if ($DefaultSite) { $config['default'] = $site}
            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                Export-Configuration $config
            }
            $config

        }

}
