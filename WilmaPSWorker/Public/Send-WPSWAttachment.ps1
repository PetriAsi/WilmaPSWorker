<#
.SYNOPSIS
Get pdf printout from generic databases
#>
function Send-WPSWAttachment (){
    [CmdletBinding()]
    param(
      # Database
      [Parameter(Mandatory=$true)]
      [validateSet('explearning','skilldemo','explearningplaces')]
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
      $file

    )
    begin{
      Write-Verbose "Send-WPSWAttachment begin"
      $WPSWSession = Get-WPSWCurrentSession
      $basepath = "/attachments/upload"

      $database_ids = @{
        explearning = 'suortopit'
        explearningplaces = 'tyossaopp'
        skilldemo = 'suornaytot'
      }
      try {
        $file = get-item -Path $file
      }
      catch {
        throw "Send-WPSWAttachment : Cannot find file $file"
      }

      Write-Verbose "Send-WPSWAttachment compose multipart content"

      $multipartContent = [System.Net.Http.MultipartFormDataContent]::new()

      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "tid"
      $StringContent = [System.Net.Http.StringContent]::new($card_id)
      $StringContent.Headers.ContentDisposition = $stringHeader
      $multipartContent.Add($stringContent)

      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "tdb"
      $StringContent = [System.Net.Http.StringContent]::new($database_ids[$Database])
      $StringContent.Headers.ContentDisposition = $stringHeader
      $multipartContent.Add($stringContent)

      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "formid"
      $StringContent = [System.Net.Http.StringContent]::new($form_id)
      $StringContent.Headers.ContentDisposition = $stringHeader
      $multipartContent.Add($stringContent)

      $stringHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $stringHeader.Name = "formkey"
      $StringContent = [System.Net.Http.StringContent]::new($WPSWSession.Result.FormKey)
      $StringContent.Headers.ContentDisposition = $stringHeader
      $multipartContent.Add($stringContent)

      $multipartFile = $file
      $FileStream = [System.IO.FileStream]::new($multipartFile, [System.IO.FileMode]::Open)
      $fileHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
      $fileHeader.Name = "files"
      $fileHeader.FileName = $file.Name
      $fileContent = [System.Net.Http.StreamContent]::new($FileStream)
      $fileContent.Headers.ContentDisposition = $fileHeader
      $fileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("application/octet-stream")
      $multipartContent.Add($fileContent)

    }

    process {
      Write-Verbose "Send-WPSWAttachment process"

      try {
        Write-Verbose "$($WPSWSession.config.url)$basepath"
        $result = Invoke-WebRequest -Method Post -Uri "$($WPSWSession.config.url)$basepath"  -ContentType 'multipart/form-data' -Body $multipartContent -WebSession $WPSWSession.WilmaSession
        if($result.Statuscode -ne 200){
          Write-Warning "Problem generating printout. Statuscode $($result.Statuscode) "
        }
        $result
      }
      catch{
        Write-Error "Could not upload attachment."
      }
  }
}
