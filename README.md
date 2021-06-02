# WilmaPSWorker

Powershell tools for Visma Wilma and optionaly also with Primus via primusquery

## Overview
Collection of tools that make working with Wilma little bit easier and more secure.
This module requires powershell version 7 to run. It runs nicely side by side with
older one so dont be shy and just [install it](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7.1)

### Features

#### Wilma features
 - Send and receive wilma messages
 - Search and list messages recipients
 - Download profile pictures
 - Upload attachments
 - Dowload wilma printouts as pdf-files
#### Primusqury features
 - import and export data
 - automaticly parse csv or xml formatted queryresults to powershell objects

#### Multiple sites
Setup multiple sites for different wilma-sites or to use diffrent credentials.

## Installation
Install module from PowerShell gallery

```powershell
Install-Module WilmaPSWorker
```

## Examples

### Setup new site

```powershell
New-WPSWSite -site MyWilma -wilma_url https://mysite.inschool.fi -wilma_apikey xxxxxxxxxxxxxx -wilma_cred (get-Credential -message "Wilma credentials") -pq_host primus.server.fi -pq_port 1222 -pq_cred (get-credential -Message "Primus credentials")
```

After you have setup the site, use just connect-wpswsite in scripts.

### Connect site

```powershell
Connect-WPSWSite
```

### Search for message recipient

```powershell
Get-WPSWRecipient -Search "petri asikainen" | ConvertFrom-Json

PersonnelRecords
----------------
{@{Id=107; Caption=Asikainen Petri (P.A); SchoolIDs=5,2,4,6,10,11,1; AllowPersonnel=}}
```

### Send wilma message

```powershell

Send-WPSWmessage -MessageBody "This is test message sent with powershell" -Subject "Testing again" -r_personnel 107
{"Status":"Sent"}
```




