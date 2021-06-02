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

### Basic query
```
Invoke-WPSWPrimusQuery [-QueryName] <String> [-Outfile <String>] [-Parameters <String[]>] [<CommonParameters>]
```

### Format results
```
Invoke-WPSWPrimusQuery [-QueryName] <String> -ParseResults <String> [-Delimiter <String>] [-Header <String[]>]
 [-Parameters <String[]>] [<CommonParameters>]
```

### Import data
```
Invoke-WPSWPrimusQuery [-QueryName] <String> -Infile <String> [<CommonParameters>]
```

## DESCRIPTION
Invokes primusquery, exports and imports data from Primus.
Exported data can be saved
to file or processes as XML or CSV formating.

## EXAMPLES

### EXAMPLE 1
```
Invoke-WPSWPrimusQuery -QueryName students -Outfile students.txt
```

Saves primusquery output to student.txt

### EXAMPLE 2
```
Invoke-WPSWPrimusQuery -QueryName classes -ParseResults csv -Delimiter '|'
```

Invokes query, parses results as csv and returns result lines as powershell objects

### EXAMPLE 3
```
Invoke-WPSWPrimusQuery -QueryName applicants -ParseResults xml -Parameters "3.4.2021"
```

Invokes query with parameters to get applicants, parses results as xml and returns result as xml object

### EXAMPLE 4
```
Invoke-WPSWPrimusQuery -QueryName Grades -Infile new-grades
```

Imports data to primus

## PARAMETERS

### -Delimiter
CSV delimiter

```yaml
Type: String
Parameter Sets: Format results
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
Parameter Sets: Format results
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
Parameter Sets: Import data
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
Parameter Sets: Basic query
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
Parameter Sets: Basic query, Format results
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
Parameter Sets: Format results
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
