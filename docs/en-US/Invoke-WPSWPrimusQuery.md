---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Invoke-WPSWPrimusQuery

## SYNOPSIS
{{ Fill in the Synopsis }}

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
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Delimiter
{{ Fill Delimiter Description }}

```yaml
Type: String
Parameter Sets: Format
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Header
{{ Fill Header Description }}

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
{{ Fill Infile Description }}

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
{{ Fill Outfile Description }}

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
{{ Fill Parameters Description }}

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
{{ Fill ParseResults Description }}

```yaml
Type: String
Parameter Sets: Format
Aliases:
Accepted values: xml, csv

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryName
{{ Fill QueryName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
