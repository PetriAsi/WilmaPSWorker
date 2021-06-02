<#
.Synopsis
Creates new Wilma site , sets addresses and needed credentials.
.Description
Setup new site to connect Wilma via http and/or Primus with primusquery.

.EXAMPLE
New-WPSWSite -site MyWilma -wilma_url https://mysite.inschool.fi -wilma_apikey xxxxxxxxxxxxxx -wilma_cred (get-Credential -message "Wilma credentials") -pq_host primus.server.fi -pq_port 1222 -pq_cred (get-credential -Message "Primus credentials") -pq_exe "c:\Primusquery\primusquery.exe"

Setups new site
#>
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

         # Primusquery port
         [string]
         $pq_port,

         # Credential to use with primusquery]
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
            if ($pq_port) { $newsite.pq_port = $pq_port}
            if ($pq_cred) { $newsite.pq_cred = $pq_cred}
            if ($pq_exe)  { $newsite.pq_exe = $pq_exe}

            $config.sites[$site] = $newsite
            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                Export-Configuration $config
            }
        }

}
