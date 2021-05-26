function New-WPWSSite(){
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
        [object]
        $wilma_cred = (get-credential ))


        $config = Get-WPSWConfig

        if($config.sites[$site]) {
            Write-Error "Site $site already exists."
        } else {
            $newsite=@{
                site = $site
                url = $wilma_url
                apikey = $wilma_apikey
                cred = $wilma_cred
            }

            $config.sites[$site] = $newsite
            Export-Configuration
        }

}
