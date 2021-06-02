---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Invoke-WPSWPrimusQuery

## SYNOPSIS
Invokes primusquery, exports and imports data from Primus.

## SYNTAX

### Query
```
Invoke-WPSWPrimusQuery [-QueryName] <String> [-Outfile <String>] [-Parameters <String[]>] [<CommonParameters>]
```

### Format
```
Invoke-WPSWPrimusQuery [-QueryName] <String> -ParseResults <String> [-Delimiter <String>] [-Header <String[]>]
 [-Parameters <String[]>] [<CommonParameters>]
```

### Import
```
Invoke-WPSWPrimusQuery [-QueryName] <String> -Infile <String> [<CommonParameters>]
```

## DESCRIPTION
Invokes primusquery, exports and imports data from Primus.
Exported data can be saved
to file or processes as XML or CSV formating.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Delimiter
CSV delimiter

```yaml
Type: String
Parameter Sets: Format
Aliases:

Required: False
Position: Named
Default value: ;
Accept pipeline input: False
Accept wildcard characters: False
```

### -Header
Column names for csv file

```yaml
Type: String[]
Parameter Sets: Format
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Infile
File to import to primus

```yaml
Type: String
Parameter Sets: Import
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Outfile
Write output to file

```yaml
Type: String
Parameter Sets: Query
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parameters
Parameters for primusquery, supports also arrays.
In primusquery you can use %p1% , %p2% ...
for multiple parameters

```yaml
Type: String[]
Parameter Sets: Query, Format
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParseResults
Parse results and return as parsed psobjects

```yaml
Type: String
Parameter Sets: Format
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryName
Queryname on primus

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
