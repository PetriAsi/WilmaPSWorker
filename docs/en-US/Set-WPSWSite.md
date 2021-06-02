---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# Set-WPSWSite

## SYNOPSIS
Set site settings

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
Changes site defination, urls , hostnames or credentials used to connect Wilma or Primus

## EXAMPLES

### EXAMPLE 1
```
Set-WPSWSite -site MyWilma -wilma_cred (get-Credential -message "Wilma credentials")
```

Changes wilma credentials

### EXAMPLE 2
```
Set-WPSWSite -site MyWilma -pq_host primus.server.fi -pq_port 1222 -pq_cred (get-credential -Message "Primus credentials") -pq_exe "c:\Primusquery\primusquery.exe"
```

Adds or updates primusquery setting on specific site

## PARAMETERS

### -DefaultSite
set Site as default

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -pq_cred
Creadential to use with primusquery

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
Path to primusquery excutable

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
Primusquery host

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
Primusquery port

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
Short name for wilma site

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
Wilma api-key

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
Wilma usercredential

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
Wilma site url

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

## OUTPUTS

## NOTES

## RELATED LINKS
