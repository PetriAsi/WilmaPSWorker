param(
    [string[]]$Tasks
)



function Install-Dependency([string] $Name)
{
    $policy = Get-PSRepository -Name "PSGallery" | Select-Object -ExpandProperty "InstallationPolicy"
    if($policy -ne "Trusted") {
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    }

    if (!(Get-Module -Name $Name -ListAvailable)) {
        Install-Module -Name $Name -Scope CurrentUser
    }
}

function Run-Tests
{
    param(
        [string]$Path = "$PSScriptRoot\WilmaPSWorker"
    )

    $results = Invoke-Pester -PassThru
    if($results.FailedCount -gt 0) {
       Write-Output "  > $($results.FailedCount) tests failed. The build cannot continue."
       foreach($result in $($results.TestResult | Where-object {$_.Passed -eq $false} | Select-Object -Property Describe,Context,Name,Passed,Time)){
            Write-Output "    > $result"
       }

       EXIT 1
    }
}

function Release
{
    Write-Output "Setting Variables"
    $BuildRoot = $env:CI_PROJECT_DIR
    $releasePath = "$BuildRoot\Release"

    if (-not (Test-Path "$releasePath\WilmaPSWorker")) {
        $null = New-Item -Path "$releasePath\WilmaPSWorker" -ItemType Directory
    }

    # Copy module
    Copy-Item -Path "$BuildRoot\WilmaPSWorker\*" -Destination "$releasePath\WilmaPSWorker" -Recurse -Force
    # Copy additional files
    $additionalFiles = @(
        "$BuildRoot\CHANGELOG.md"
        "$BuildRoot\LICENSE"
        "$BuildRoot\README.md"
    )
    Copy-Item -Path $additionalFiles -Destination "$releasePath\WilmaPSWorker" -Force


    $manifestContent = Get-Content -Path "$releasePath\WilmaPSWorker\WilmaPSWorker.psd1" -Raw
    if ($manifestContent -notmatch '(?<=ModuleVersion\s+=\s+'')(?<ModuleVersion>.*)(?='')') {
        throw "Module version was not found in manifest file,"
    }

    $currentVersion = [Version] $Matches.ModuleVersion
    if ($env:CI_JOB_ID) {
        $newRevision = $env:CI_JOB_ID
    }
    else {
        $newRevision = 0
    }
    $version = New-Object -TypeName System.Version -ArgumentList $currentVersion.Major,
    $currentVersion.Minor,
    $newRevision

    Write-Output "New version : $version"

    Update-Metadata -Path "$releasePath\WilmaPSWorker\WilmaPSWorker.psd1" -PropertyName ModuleVersion -Value $version
    $functionsToExport = Get-ChildItem "$BuildRoot\WilmaPSWorker\Public" | ForEach-Object {$_.BaseName}
    Set-ModuleFunctions -Name "$releasePath\WilmaPSWorker\WilmaPSWorker.psd1" -FunctionsToExport $functionsToExport

    #Remove-Module WilmaPSWorker
    Import-Module $env:CI_PROJECT_DIR\WilmaPSWorker\WilmaPSWorker.psd1 -force -ErrorAction Stop
    Publish-Module -Name WilmaPSWorker -Repository InternalPowerShellModules -NuGetApiKey 123456789
}

foreach($task in $Tasks){
    switch($task)
    {
        "test" {
            Install-Dependency -Name "PSScriptAnalyzer"
            Install-Dependency -Name "Pester"
            Write-Output "Running Pester Tests..."
            Run-Tests
        }
        "release" {
            Write-Output "Releasing..."
            Install-Dependency -Name Configuration
            Release
        }
    }
}
