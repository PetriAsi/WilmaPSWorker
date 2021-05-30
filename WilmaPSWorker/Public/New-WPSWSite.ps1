function New-WPSWSite(){
    [CmdletBinding(SupportsShouldProcess)]
    param(
        # Short name for wilma site
        [Parameter(Mandatory=$true)]
        [string]
        $site,

        # Wilma site url
        [Parameter(Mandatory=$true)]
        [string]
        $wilma_url,

        # Wilma api-key
        [Parameter(Mandatory=$true)]
        [string]
        $wilma_apikey,

        # Wilma usercredential
        [Parameter(Mandatory=$true)]
        [PSCredential]
        $wilma_cred,

         # Primusquery host
         [string]
         $pq_host,

         # Creadential to use with primusqueryetName = "PQ")]

         [PSCredential]
         $pq_cred,

         # Path to primusquery excutable
         [string]
         $pq_exe

        )


        $config = Get-WPSWConfig -all

        if(! $config.sites){
            $config.sites = @{}
        }

        if($config.sites[$site]) {
            Write-Error "Site $site already exists."
        } else {
            $newsite=@{
                site = $site
                url = $wilma_url
                apikey = $wilma_apikey
                cred = $wilma_cred
            }


            if ($pq_host) { $newsite.pq_host = $pq_host}
            if ($pq_cred) { $newsite.pq_cred = $pq_cred}
            if ($pq_exe)  { $newsite.pq_exe = $pq_exe}

            $config.sites[$site] = $newsite
            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                Export-Configuration $config
            }
        }

}
