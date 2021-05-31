<#
.SYNOPSIS
Get possible recipients
#>
function Get-WPSWRecipient (){
    [CmdletBinding()]
    param(
      #Search recipient
      [Parameter(Mandatory=$false,ParameterSetName="Search")]
      [string]
      $Search,

      #Recipient type
      [Parameter(Mandatory=$false,ParameterSetName="Query")]
      [validateSet('All','Class')]
      [string]
      $RecipientType,

      #Recipient type id
      [Parameter(Mandatory=$false,ParameterSetName="Query")]
      [int]
      $RecipientTypeID
    )

    begin{
      $WPSWSession = Get-WPSWCurrentSession

      if($RecipientType -ne 'All' -and (-not $RecipientTypeID) -and (-not $Search)){
        Write-Error "Please specify RecipientTypeID for"
      }

      $urimap =@{
        'All'   = '/messages/recipients?format=json'
        'Class'    = "/messages/recipients/class/$($RecipientTypeID)?format=json"
      }

      if ( $RecipientType) {
        $basepath = $($urimap[$RecipientTypeID])
      } else {
        if($Search){
          $basepath = "/messages/recipients/search?name=$Search&format=json"
        }
      }
    }

    process{
      try{
        Write-Verbose "$($WPSWSession.config.url)$($basepath)"
        $result = Invoke-WebRequest -Method Get -Uri "$($WPSWSession.config.url)$($basepath)" -WebSession $WPSWSession.WilmaSession
        if($result.Statuscode -eq 200) {
          $result.Content
        } else {
          Write-Error "Get-WPSWRecipient unexpected statuscode $($result.Statuscode)"
        }
      }
      catch{
        Write-Error "Could get recipients."
      }
    }
}
