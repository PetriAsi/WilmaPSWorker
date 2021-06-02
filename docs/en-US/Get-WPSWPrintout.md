---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Get-WPSWPrintout

## SYNOPSIS
Get pdf printout from wilma.

## SYNTAX

```
Get-WPSWPrintout [-Database] <String> [-print_id] <Int32> [-card_id] <Int32> [-OutFile] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Downloads genarated pdf:s from Wilma.

## EXAMPLES

### EXAMPLE 1
```
Get-WPSWPrintout -Database explearning -card_id 23656  -print_id 86 -OutFile c:\temp\test.pdf
```

Gets prinout pdf for explearning id 23656 using printsettings 86

## PARAMETERS

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

### -print_id
Print ID
Ypu can get this with browser, it's number part of generated pdf.

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

### -card_id
card ID

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

### -OutFile
Output file

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
