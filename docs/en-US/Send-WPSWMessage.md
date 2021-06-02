---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Send-WPSWMessage

## SYNOPSIS
Send wilma message to recipients

## SYNTAX

### ReplyMessage
```
Send-WPSWMessage -MessageBody <String> -Reply_id <Int32> [<CommonParameters>]
```

### NewMessage
```
Send-WPSWMessage -MessageBody <String> -Subject <String> [-ShowRecipients <Boolean>]
 [-CollatedReplies <Boolean>] [-r_student <Int32[]>] [-r_guardian <String>] [-r_teacher <Int32[]>]
 [-r_personnel <Int32[]>] [-r_instructor <Int32[]>] [-r_class <Int32[]>] [-r_classguardian <Int32[]>]
 [-r_group <Int32[]>] [-r_groupguardian <Int32[]>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Send-WPSWMessage -MessageBody "just testing" -Subject "test"" -r_student 123
```

Sends a message to student with id 123

### EXAMPLE 2
```
Send-WPSWMessage -MessageBody "This is ok" -Reply_id 12345
```

Replies to message with id 12345

## PARAMETERS

### -MessageBody
Message Body

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subject
Message subject

```yaml
Type: String
Parameter Sets: NewMessage
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reply_id
Message is reply to message id

```yaml
Type: Int32
Parameter Sets: ReplyMessage
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowRecipients
whether the recipient is able to see the names of the other recipients

```yaml
Type: Boolean
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CollatedReplies
whether the recipients are able to see each other's responses (can answer by Quick Reply)

```yaml
Type: Boolean
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_student
Recipient Student ID

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_guardian
Recipient guardian for student ID If the student has two guardians (personal accounts in use) and you
only want to choose one of the guardians as a recipient, create the value
Id+_+ PasswdID

```yaml
Type: String
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_teacher
Recipient teacher ID

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_personnel
Recipient personel ID

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_instructor
Recipient workplace instructor ID

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_class
Recipient Class ID

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_classguardian
Recipient class supervisor ID

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_group
Recipient Group ID

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -r_groupguardian
teacher ID of the group

```yaml
Type: Int32[]
Parameter Sets: NewMessage
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
