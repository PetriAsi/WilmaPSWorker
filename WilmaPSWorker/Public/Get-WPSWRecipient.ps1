<#
.SYNOPSIS
Seach or get possible recipients

.EXAMPLE
Get-WPSWRecipient -Search "Some user" | ConvertFrom-Json

Returns search results grouped by usertype
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

      #Recipient type ID. This is id number of class
      [Parameter(Mandatory=$false,ParameterSetName="Query")]
      [int]
      $RecipientTypeID
    )

    begin{
      $WPSWSession = Get-WPSWCurrentSession

      if($RecipientType -ne 'All' -and (-not $RecipientTypeID) -and (-not $Search)){
        Throw "Please specify RecipientTypeID for $RecipientType"
      }

      $urimap =@{
        'All'   = '/messages/recipients?format=json'
        'Class'    = "/messages/recipients/class/$($RecipientTypeID)?format=json"
      }

      if ( $RecipientType) {
        $basepath = $urimap[$RecipientType]
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
