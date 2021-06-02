---
external help file: WilmaPSWorker-help.xml
Module Name: WilmaPSWorker
online version:
schema: 2.0.0
---

# New-WPSWSite

## SYNOPSIS
Creates new Wilma site , sets addresses and needed credentials.

## SYNTAX

```
New-WPSWSite [-site] <String> [-wilma_url] <String> [-wilma_apikey] <String> [-wilma_cred] <PSCredential>
 [[-pq_host] <String>] [[-pq_port] <String>] [[-pq_cred] <PSCredential>] [[-pq_exe] <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Setup new site to connect Wilma via http and/or Primus with primusquery.

## EXAMPLES

### EXAMPLE 1
```
New-WPSWSite -site MyWilma -wilma_url https://mysite.inschool.fi -wilma_apikey xxxxxxxxxxxxxx -wilma_cred (get-Credential -message "Wilma credentials") -pq_host primus.server.fi -pq_port 1222 -pq_cred (get-credential -Message "Primus credentials") -pq_exe "c:\Primusquery\primusquery.exe"
```

Setups new site

## PARAMETERS

### -pq_cred
Credential to use with primusquery\]

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pq_exe
Path to primusquery excutable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -pq_host
Primusquery host

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
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
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wilma_apikey
Wilma api-key

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wilma_cred
Wilma usercredential

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wilma_url
Wilma site url

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
