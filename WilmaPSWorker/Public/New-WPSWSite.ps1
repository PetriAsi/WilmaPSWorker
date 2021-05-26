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
        $wilma_cred
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

            $config.sites[$site] = $newsite
            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                Export-Configuration $config
            }
        }

}
