<#
.SYNOPSIS
Uploads attachment to wilma

.EXAMPLE
Send-WPSWAttachment -Database students -card_id 12345 -form_id 7

Send attachment to to student with id 12345. -form_id 7 is number of form.

#>
function Send-WPSWAttachment (){
    [CmdletBinding()]
    param(
      # Database
      [Parameter(Mandatory=$true)]
      [validateSet('students','explearning','skilldemo','explearningplaces')]
      [string]
      $Database,

      # card ID
      [Parameter(Mandatory=$true)]
      [int]
      $card_id,

      # Form id to attach file to
      [Parameter(Mandatory=$true)]
      [int]
      $form_id,

      # File to attach
      [Parameter(Mandatory=$true)]
      [string]
      $toAttach

    )
    begin{
      Write-Verbose "Send-WPSWAttachment begin"
      $WPSWSession = Get-WPSWCurrentSession
      $basepath = "/attachments/upload"

      $database_ids = @{
        explearning = 'suortopit'
        explearningplaces = 'tyossaopp'
        skilldemo = 'suornaytot'
        students = 'opphenk'
      }

      $referer = "$($WPSWSession.config.url)$($basepath)?tid=$card_id&tdb=$($database_ids[$Database])&formid=$form_id"
      Write-Debug "generated referer: $referer"

      try {
        $fileItem = get-item -Path $toAttach
      }
      catch {
        throw "Send-WPSWAttachment : Cannot find file $file"
      }

      Write-Verbose "Send-WPSWAttachment compose multipart content"
      
      $multipartContent = [System.Net.Http.MultipartFormDataContent]::new()

      #content-type headers for name values makes wilma confused
      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "formkey"
      $StringContent = [System.Net.Http.StringContent]::new($WPSWSession.Result.FormKey)
      $StringContent.Headers.ContentDisposition = $stringHeader
      $res = $StringContent.Headers.Remove('Content-Type')
      $multipartContent.Add($stringContent)

      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "formid"
      $StringContent = [System.Net.Http.StringContent]::new($form_id)
      $StringContent.Headers.ContentDisposition = $stringHeader
      $res = $StringContent.Headers.Remove('Content-Type')
      $multipartContent.Add($stringContent)

      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "targetid"
      $StringContent = [System.Net.Http.StringContent]::new($card_id)
      $StringContent.Headers.ContentDisposition = $stringHeader
      $res = $StringContent.Headers.Remove('Content-Type')
      $multipartContent.Add($stringContent)

      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "targetdb"
      $StringContent = [System.Net.Http.StringContent]::new($database_ids[$Database])
      $StringContent.Headers.ContentDisposition = $stringHeader
      $res = $StringContent.Headers.Remove('Content-Type')
      $multipartContent.Add($stringContent)

      $multipartFile = $fileItem.FullName
      $FileStream = [System.IO.FileStream]::new($multipartFile, [System.IO.FileMode]::Open)
      $fileHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $fileHeader.Name = "files"
      $fileHeader.FileName = $fileItem.Name
      $fileContent = [System.Net.Http.StreamContent]::new($FileStream)
      $fileContent.Headers.ContentDisposition = $fileHeader
      #Hack to prevent filename escaping and keep uft8
      ($fileContent.Headers.ContentDisposition.Parameters| Where-Object { $_.Name -eq 'filename'}).Value = $fileItem.Name
      if ((Split-Path -Path $fileItem.Name -Extension) -eq '.pdf' ){
        $fileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("application/pdf")
      } else {
        $fileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("application/octet-stream")
      }
      $multipartContent.Add($fileContent)


      $Headers = @{
        referer = $referer
        origin = $WPSWSession.config.url
        dnt = 1
        accept = "application/json, text/javascript, */*; q=0.01"
      }

      Write-Verbose $multipartContent.Headers
    }

    process {
      Write-Verbose "Send-WPSWAttachment process"

      try {
        Write-Verbose "$($WPSWSession.config.url)$basepath"
        $result = Invoke-WebRequest  -Method Post  -Headers $Headers   -Uri "$($WPSWSession.config.url)$basepath"  -ContentType 'multipart/form-data; charset=utf8' -Body $multipartContent -WebSession $WPSWSession.WilmaSession

        #Add $result.content check as almost all requests are returning 200
        try {$content = $result.content | ConvertFrom-Json
        }
        catch {
          Write-error "Send-WPSWAttachment cant parse upload results"
        }

        if($result.Statuscode -ne 200 -or ($null -eq $content.files )){
          Write-Warning "Problem uploading attachment. Statuscode $($result.Statuscode) Content: $($result.content) "
        }
        $result
      }
      catch{
        $ErrorMessage = $_.Exception.Message
        Write-Error "Could not upload attachment. $ErrorMessage"
      }
  }
}
