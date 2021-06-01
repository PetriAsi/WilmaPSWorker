<#
.Synopsis
Connects to Wilma and sets session variables
#>
function New-WPSWSession (){
    [CmdletBinding()]
    param(
      [string]
      $site = 'DEFAULT'
    )

    $config = Get-WPSWConfig -site $site

    Write-Verbose "Starting Get-WPSWSession"
    Write-Debug "Config: $config"

    $Login = $config.cred.UserName
    $password =  [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($config.cred.Password))

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $reply = Invoke-RestMethod -Uri "$($config.url)/index_json"
    $SessionId=$reply.SessionID

    $data= "$Login|$SessionId|$($config.apikey)"
    $hashString= Get-SHA1stringHash( $data )
    $Apikey = "sha1:$hashString"
    $LoginParameters = "Login=$Login&Password=$Password&SessionId=$SessionID&ApiKey=$Apikey&format=json"

    $reply = Invoke-RestMethod -Method Post -Uri "$($config.url)/login?$LoginParameters" -SessionVariable WilmaSession

    $result = @{
        LoginResult = $reply.LoginResult
        WilmaId     = $reply.WilmaId
        ApiVersion  = $reply.ApiVersion
        FormKey     = $reply.FormKey
        ConnectIds  = $reply.ConnectIds
        Slug        = $reply.Slug
        Name        = $reply.Name
        Type        = $reply.Type
        PrimusId    = $reply.PrimusId
        School      = $reply.School
    }

    if ($result.LoginResult -ne "OK") {
      Write-Debug $result
      Throw "Kirjautuminen epäonnistui"
    } else {
      @{WilmaSession=$WilmaSession
        Result = $result
        config = $config
        Site   = $site}
    }

}
