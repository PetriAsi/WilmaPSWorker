function Set-WPSWSite(){
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

            if ($DefaultSite) { $config['default'] = $site}
            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                Export-Configuration $config
            }
            $config

        }

}
