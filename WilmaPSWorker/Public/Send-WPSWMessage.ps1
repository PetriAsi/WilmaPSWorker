<#
.SYNOPSIS
Send wilma message to recipients

.EXAMPLE
 Send-WPSWMessage -MessageBody "just testing" -Subject "test"" -r_student 123

 Sends a message to student with id 123

.EXAMPLE
Send-WPSWMessage -MessageBody "This is ok" -Reply_id 12345

Replies to message with id 12345
#>
function Send-WPSWMessage (){
    [CmdletBinding()]
    param(

      # Message Body
      [Parameter(Mandatory=$true,ParameterSetName='NewMessage')]
      [Parameter(Mandatory=$true,ParameterSetName='ReplyMessage')]
      [string]
      $MessageBody,

      # Body is formad as as HTML
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [Parameter(Mandatory=$false,ParameterSetName='ReplyMessage')]
      [switch]
      $AsHTML,

      # Send message always also via email
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [Parameter(Mandatory=$false,ParameterSetName='ReplyMessage')]
      [switch]
      $AlwaysEMail,

      # Message subject
      [Parameter(Mandatory=$true,ParameterSetName='NewMessage')]
      [string]
      $Subject,

      # Message is reply to message id
      [Parameter(Mandatory=$true,ParameterSetName='ReplyMessage')]
      [int]
      $Reply_id,

      # whether the recipient is able to see the names of the other recipients
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [bool]
      $ShowRecipients=$false,

      # whether the recipients are able to see each other’s responses (can answer by Quick Reply)
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [bool]
      $CollatedReplies=$false,

      #Recipient Student ID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_student,

      #Recipient guardian for student ID If the student has two guardians (personal accounts in use) and you
      #only want to choose one of the guardians as a recipient, create the value
      #Id+_+ PasswdID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [string]
      $r_guardian,

      #Recipient teacher ID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_teacher,

      #Recipient personel ID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_personnel,
      #Recipient workplace instructor ID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_instructor,

      #Recipient Class ID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_class,

      #Recipient class supervisor ID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_classguardian,

      #Recipient Group ID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_group,

      #teacher ID of the group
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [int[]]
      $r_groupguardian,

      #Student recipients. combination of Search ID and school id as SearchID+_+SchoolID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [string]
      $r_studentsearch,

      #Guardian recipients. combination of Search ID and school id as SearchID+_+SchoolID
      [Parameter(Mandatory=$false,ParameterSetName='NewMessage')]
      [string]
      $r_guardiansearch
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
      }


      if ($true -eq $AsHTML) {
          $Body += @{
            wysiwyg = "ckeditor"
          }
      }

      if ($true -eq $AlwaysEmail) {
        $Body += @{
          AlwaysEmail = "true"
        }
      }

      if ( -not $Reply_id) {
        $Body += @{
          Subject = $Subject
          ShowRecipients = $ShowRecipients
          CollatedReplies =$CollatedReplies
        }

        $recipients= ('r_student', 'r_guardian','r_teacher','r_personnel','r_instructor','r_class','r_classguardian','r_group','r_groupguardian', 'r_studentsearch', 'r_guardiansearch')
        foreach ( $r in $recipients) {
          if((Get-Variable $r).Value) {
            $Body.$($r) = (Get-Variable $r).Value
          }
        }
      } else {
        #this is reply
        $basepath = "/messages/collatedreply/$Reply_id"
      }
      try {
        $requesturl = "$($WPSWSession.config.url)$basepath"
        Write-Verbose $requesturl
        $result = Invoke-RestMethod -Headers $Headers -SkipHttpErrorCheck -Method Post  -MaximumRedirection 0 -ResponseHeadersVariable ResponseHeader -Form $Body  -Uri $requesturl  -WebSession $WPSWSession.WilmaSession

        #'/messages/compose' unsuccefull sending
        if($ResponseHeader.Location -eq "$($WPSWSession.config.url)/messages" -or
           $ResponseHeader.Location -eq "$($WPSWSession.config.url)/messages/$Reply_id") {
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
