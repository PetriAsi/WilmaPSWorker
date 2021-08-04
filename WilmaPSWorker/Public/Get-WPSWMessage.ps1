<#
.SYNOPSIS
Get Wilma messages
.DESCRIPTION
Get all wilma messages, messages from selected folder Inbox , Sent , Archive or Drafts.
Or message content for specific message

.EXAMPLE
Get-WPSWMessage -Folder Inbox
Gets messagelist from Inbox folder

.EXAMPLE
Get-WPSWMessage -Message_id 12345

Gets message content for message id 12345
#>
function Get-WPSWMessage (){
    [CmdletBinding()]
    param(
      #Message id
      [Parameter(Mandatory=$true,ParameterSetName='Message content')]
      [int]
      $Message_id,
      #Mailfolder
      [Parameter(Mandatory=$true,ParameterSetName='List messages')]
      [validateSet('Inbox','Sent','Archive','Drafts','All')]
      [string]
      $Folder
    )
    begin{
      Write-Verbose "Get-WPSWMessage - Begin"
      try {
        $WPSWSession = Get-WPSWCurrentSession
      } catch {
        Throw "Get-WPSWMessage - Cannot get Current WPSWSession."
      }


      $urimap =@{
        'Inbox'     = '/messages/index_json'
        'Sent'      = '/messages/index_json/outbox'
        'Archive'   = '/messages/index_json/archive'
        'Drafts'    = '/messages/index_json/drafts'
        'All'       = '/messages/index_json/all'
      }

    }
    process {
      write-verbose "Get-WPSWMessage - Session : $WPSWSession"

      try {

        if ($Message_id){
          $baseslug = "/messages/$Message_id"
        } else {
          $baseslug = $urimap[$Folder]
        }

        $targeturl = "$($WPSWSession.config.url)$baseslug"
        Write-Verbose "Targeturl: $targeturl"
        $result = Invoke-WebRequest -Method Get -Uri $targeturl -WebSession $WPSWSession.WilmaSession
        if($result.Statuscode -eq 200) {
          $result.Content
        } else {
          Write-Error "Get-WPSWMessage unexpected statuscode $($result.Statuscode)"
        }
      }
      catch{
        $ErrorMessage = $_.Exception.Message
        Write-Error "Could not get messages. $ErrorMessage"
      }
    }
}
