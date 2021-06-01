<#
.SYNOPSIS
Get messages
.DESCRIPTION
Get all wilma messages or messages from selected folder Inbox , Sent , Archive or Drafts.
#>
function Get-WPSWMessage (){
    [CmdletBinding()]
    param(
      #Mailfolder
      [Parameter(Mandatory=$true)]
      [validateSet('Inbox','Sent','Archive','Drafts','All')]
      [string]
      $Folder
    )
    $WPSWSession = Get-WPSWCurrentSession
    try {
      $urimap =@{
        'Inbox'   = '/messages/index_json'
        'Sent'    = '/messages/index_json/outbox'
        'Archive' = '/messages/index_json/archive'
        'Drafts'  = '/messages/index_json/drafts'
        'All'     = '/messages/index_json/all'
      }

      Write-Verbose "$($WPSWSession.config.url)$($urimap[$Folder]) $($OutFile)"
      $result = Invoke-WebRequest -Method Get -Uri "$($WPSWSession.config.url)$($urimap[$Folder])" -WebSession $WPSWSession.WilmaSession
      if($result.Statuscode -eq 200) {
        $result.Content
      } else {
        Write-Error "Get-WPSWMessage unexpected statuscode $($result.Statuscode)"
      }
    }
    catch{
      Write-Error "Could get messages."
    }

}
