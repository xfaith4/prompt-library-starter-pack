[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter()]
    [ValidateSet('Stable', 'Insiders', 'Both')]
    [string]$Channel = 'Stable',

    [Parameter()]
    [string]$SourceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,

    [Parameter()]
    [switch]$IncludeArchive,

    [Parameter()]
    [Alias('Sync')]
    [switch]$PruneStale
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-TargetRoots {
    param(
        [Parameter(Mandatory)]
        [string]$SelectedChannel
    )

    $roots = @()

    if ($SelectedChannel -eq 'Stable' -or $SelectedChannel -eq 'Both') {
        $roots += Join-Path $env:APPDATA 'Code\User\prompts\prompt-library-starter-pack'
    }

    if ($SelectedChannel -eq 'Insiders' -or $SelectedChannel -eq 'Both') {
        $roots += Join-Path $env:APPDATA 'Code - Insiders\User\prompts\prompt-library-starter-pack'
    }

    return $roots
}

if (-not (Test-Path -Path $SourceRoot)) {
    throw "Source root not found: $SourceRoot"
}

$sourcePromptFiles = Get-ChildItem -Path $SourceRoot -Recurse -File -Filter '*.prompt.md' |
    Where-Object {
        if ($IncludeArchive) {
            return $true
        }

        return $_.FullName -notmatch '[\\/]99-archive[\\/]'
    }

if (@($sourcePromptFiles).Count -eq 0) {
    throw "No .prompt.md files found under: $SourceRoot"
}

$sourceRootWithSlash = $SourceRoot.TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
$targetRoots = Get-TargetRoots -SelectedChannel $Channel

foreach ($targetRoot in $targetRoots) {
    $expectedRelativePaths = @{}

    foreach ($file in $sourcePromptFiles) {
        $relativePath = $file.FullName.Substring($sourceRootWithSlash.Length)
        $expectedRelativePaths[$relativePath.ToLowerInvariant()] = $true
        $destinationPath = Join-Path $targetRoot $relativePath
        $destinationDirectory = Split-Path -Path $destinationPath -Parent

        if (-not (Test-Path -Path $destinationDirectory)) {
            if ($PSCmdlet.ShouldProcess($destinationDirectory, 'Create directory')) {
                New-Item -Path $destinationDirectory -ItemType Directory -Force | Out-Null
            }
        }

        if ($PSCmdlet.ShouldProcess($destinationPath, 'Copy prompt file')) {
            Copy-Item -Path $file.FullName -Destination $destinationPath -Force
        }
    }

    if ($PruneStale -and (Test-Path -Path $targetRoot)) {
        $installedPromptFiles = Get-ChildItem -Path $targetRoot -Recurse -File -Filter '*.prompt.md' -ErrorAction SilentlyContinue
        $removedCount = 0

        foreach ($installedFile in $installedPromptFiles) {
            $installedRelativePath = $installedFile.FullName.Substring($targetRoot.Length).TrimStart('\', '/')

            if (-not $expectedRelativePaths.ContainsKey($installedRelativePath.ToLowerInvariant())) {
                if ($PSCmdlet.ShouldProcess($installedFile.FullName, 'Remove stale prompt file')) {
                    Remove-Item -Path $installedFile.FullName -Force
                    $removedCount++
                }
            }
        }

        $emptyDirectories = Get-ChildItem -Path $targetRoot -Recurse -Directory |
            Sort-Object -Property FullName -Descending |
            Where-Object { @(Get-ChildItem -Path $_.FullName -Force).Count -eq 0 }

        foreach ($emptyDirectory in $emptyDirectories) {
            if ($PSCmdlet.ShouldProcess($emptyDirectory.FullName, 'Remove empty directory')) {
                Remove-Item -Path $emptyDirectory.FullName -Force
            }
        }

        Write-Output ("Pruned {0} stale prompts from: {1}" -f $removedCount, $targetRoot)
    }

    Write-Output ("Installed {0} prompts to: {1}" -f @($sourcePromptFiles).Count, $targetRoot)
}
