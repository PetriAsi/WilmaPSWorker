function Set-WPSWSite(){
    param(
        # Short name for wilma site
        [Parameter(Mandatory=$true)]
        [string]
        $site,

        # Wilma site url
        [string]
        $wilma_url,

        # Wilma api-key
        [string]
        $wilma_apikey,

        # Wilma usercredential
        [PSCredential]
        $wilma_cred,

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

            Export-Configuration $config
            $config

        }

}
