---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Set-WPSWSite

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Wilma
```
Set-WPSWSite -site <String> [-wilma_url <String>] [-wilma_apikey <String>] [-wilma_cred <PSCredential>]
 [-pq_port <String>] [-DefaultSite] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### PQ
```
Set-WPSWSite -site <String> [-pq_host <String>] [-pq_port <String>] [-pq_cred <PSCredential>]
 [-pq_exe <String>] [-DefaultSite] [-WhatIf] [-Confirm] [<CommonParameters>]
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

### -DefaultSite
{{ Fill DefaultSite Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pq_cred
{{ Fill pq_cred Description }}

```yaml
Type: PSCredential
Parameter Sets: PQ
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pq_exe
{{ Fill pq_exe Description }}

```yaml
Type: String
Parameter Sets: PQ
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pq_host
{{ Fill pq_host Description }}

```yaml
Type: String
Parameter Sets: PQ
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pq_port
{{ Fill pq_port Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
{{ Fill site Description }}

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

### -wilma_apikey
{{ Fill wilma_apikey Description }}

```yaml
Type: String
Parameter Sets: Wilma
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wilma_cred
{{ Fill wilma_cred Description }}

```yaml
Type: PSCredential
Parameter Sets: Wilma
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wilma_url
{{ Fill wilma_url Description }}

```yaml
Type: String
Parameter Sets: Wilma
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
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
