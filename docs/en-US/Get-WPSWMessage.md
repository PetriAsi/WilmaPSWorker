---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Get-WPSWMessage

## SYNOPSIS
Get Wilma messages

## SYNTAX

### Message content
```
Get-WPSWMessage -Message_id <Int32> [<CommonParameters>]
```

### List messages
```
Get-WPSWMessage -Folder <String> [<CommonParameters>]
```

## DESCRIPTION
Get all wilma messages, messages from selected folder Inbox , Sent , Archive or Drafts.
Or message content for specific message

## EXAMPLES

### EXAMPLE 1
```
Get-WPSWMessage -Folder Inbox
Gets messagelist from Inbox folder
```

### EXAMPLE 2
```
Get-WPSWMessage -Message_id 12345
```

Gets message content for message id 12345

## PARAMETERS

### -Message_id
Message id

```yaml
Type: Int32
Parameter Sets: Message content
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Folder
Mailfolder

```yaml
Type: String
Parameter Sets: List messages
Aliases:

Required: True
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
