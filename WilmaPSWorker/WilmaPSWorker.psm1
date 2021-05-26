# Dot source public/private functions
Write-Warning "Starting to load"
$public  = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public/*.ps1')  -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private/*.ps1') -Recurse -ErrorAction Stop)
Write-Warning "Starting to load $public"
Write-Warning "Starting to load $private"

foreach ($import in @($public + $private)) {
    try {
        Import-Module  $import.FullName
    } catch {
        throw "Unable to import-module [$($import.FullName)]"
    }
}

