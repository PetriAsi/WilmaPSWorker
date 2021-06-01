<#
.SYNOPSIS
Get pdf printout from generic databases
#>
function Send-WPSWMessage (){
    [CmdletBinding()]
    param(

      # Message Body
      [Parameter(Mandatory=$true)]
      [string]
      $MessageBody,

      # Message subject
      [Parameter(Mandatory=$true)]
      [string]
      $Subject,

      # whether the recipient is able to see the names of the other recipients
      [Parameter(Mandatory=$false)]
      [bool]
      $ShowRecipients=$false,

      # whether the recipients are able to see each other’s responses (can answer by Quick Reply)
      [Parameter(Mandatory=$false)]
      [bool]
      $CollatedReplies=$false,

      #Recipient Student ID
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_student,

      #Recipient guardian for student ID If the student has two guardians (personal accounts in use) and you
      #only want to choose one of the guardians as a recipient, create the value
      #Id+_+ PasswdID
      [Parameter(Mandatory=$false)]
      [string]
      $r_guardian,

      #Recipient teacher ID
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_teacher,

      #Recipient personel ID
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_personnel,
      #Recipient workplace instructor ID
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_instructor,

      #Recipient Class ID
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_class,

      #Recipient class supervisor ID
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_classguardian,

      #Recipient Group ID
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_group,

      #teacher ID of the group
      [Parameter(Mandatory=$false)]
      [int[]]
      $r_groupguardian
    )

    begin{
      Write-Verbose "Send-WPSWMessage begin"
      $WPSWSession = Get-WPSWCurrentSession
      $basepath = "/messages/compose"

      $Headers = @{
        referer = $referer
        origin = $WPSWSession.config.url
        dnt = 1
      }
    }

    process {
      Write-Verbose "Send-WPSWMessage process"
      $Body= @{
        formkey = $WPSWSession.Result.FormKey
        bodyText = $MessageBody
        Subject = $Subject
        ShowRecipients = $ShowRecipients
        CollatedReplies =$CollatedReplies
      }

      $recipients= ('r_student', 'r_guardian','r_teacher','r_personnel','r_instructor','r_class','r_classguardian','r_group','r_groupguardian')
      foreach ( $r in $recipients) {
        if((Get-Variable $r).Value) {
          $Body.$($r) = (Get-Variable $r).Value
        }
      }

      try {
        Write-Verbose "$($WPSWSession.config.url)$basepath"
        $result = Invoke-RestMethod -Headers $Headers -SkipHttpErrorCheck -Method Post  -MaximumRedirection 0 -ResponseHeadersVariable ResponseHeader -Form $Body  -Uri "$($WPSWSession.config.url)$basepath"  -WebSession $WPSWSession.WilmaSession

        #'/messages/compose' unsuccefull sending
        if($ResponseHeader.Location -eq "$($WPSWSession.config.url)/messages") {
          '{"Status":"Sent"}'
        } else {

          $res=$ResponseHeader|ConvertTo-Json
          Write-Error "Unknown status when sending message. Try -Debug"
          Write-Debug $res
          Write-Debug $result
        }

      }
      catch{
        $ErrorMessage = $_.Exception.Message
        Write-Error "Could not send message: $ErrorMessage"
      }
  }
}
