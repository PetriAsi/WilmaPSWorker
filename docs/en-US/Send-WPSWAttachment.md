---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Send-WPSWAttachment

## SYNOPSIS
Uploads attachment to wilma

## SYNTAX

```
Send-WPSWAttachment [-Database] <String> [-card_id] <Int32> [-form_id] <Int32> [-toAttach] <String>
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Send-WPSWAttachment -Database students -card_id 12345 -form_id 7
```

Send attachment to to student with id 12345.
-form_id 7 is number of form.

## PARAMETERS

### -card_id
card ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Database
Database

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -form_id
Form id to attach file to

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -toAttach
File to attach

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
