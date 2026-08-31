<#
.SYNOPSIS
Installs the library's *.prompt.md files as VS Code (Copilot Chat) user prompt files.

.DESCRIPTION
Copies every *.prompt.md file (excluding 99-archive unless -IncludeArchive) directly
into the VS Code user prompts folder. Files are installed flat because VS Code prompt
discovery does not scan subfolders (microsoft/vscode#268780).

A manifest file (prompt-library-starter-pack.manifest.json) is written next to the
installed prompts so that -PruneStale and the uninstaller only ever touch files this
library installed.

.EXAMPLE
pwsh -NoProfile -File .\tools\Install-VSCode-Prompts.ps1 -Channel Both -PruneStale
#>
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

$manifestFileName = 'prompt-library-starter-pack.manifest.json'
$legacyFolderName = 'prompt-library-starter-pack'

function Get-TargetRoots {
    param(
        [Parameter(Mandatory)]
        [string]$SelectedChannel
    )

    $roots = @()

    if ($SelectedChannel -in @('Stable', 'Both')) {
        $roots += [pscustomobject]@{
            Channel    = 'Stable'
            UserFolder = Join-Path $env:APPDATA 'Code\User'
        }
    }

    if ($SelectedChannel -in @('Insiders', 'Both')) {
        $roots += [pscustomobject]@{
            Channel    = 'Insiders'
            UserFolder = Join-Path $env:APPDATA 'Code - Insiders\User'
        }
    }

    return $roots
}

if (-not (Test-Path -Path $SourceRoot)) {
    throw "Source root not found: $SourceRoot"
}

$sourcePromptFiles = @(Get-ChildItem -Path $SourceRoot -Recurse -File -Filter '*.prompt.md' |
    Where-Object {
        $IncludeArchive -or ($_.FullName -notmatch '[\\/]99-archive[\\/]')
    })

if ($sourcePromptFiles.Count -eq 0) {
    throw "No .prompt.md files found under: $SourceRoot"
}

$duplicateNames = @($sourcePromptFiles | Group-Object -Property Name | Where-Object { $_.Count -gt 1 })
if ($duplicateNames.Count -gt 0) {
    throw "Duplicate prompt file names found (files install flat, so names must be unique): $($duplicateNames.Name -join ', ')"
}

foreach ($target in Get-TargetRoots -SelectedChannel $Channel) {
    if (-not (Test-Path -Path $target.UserFolder)) {
        Write-Warning "VS Code $($target.Channel) user folder not found, skipping: $($target.UserFolder)"
        continue
    }

    $promptsRoot = Join-Path $target.UserFolder 'prompts'
    $manifestPath = Join-Path $promptsRoot $manifestFileName

    if (-not (Test-Path -Path $promptsRoot)) {
        if ($PSCmdlet.ShouldProcess($promptsRoot, 'Create prompts directory')) {
            New-Item -Path $promptsRoot -ItemType Directory -Force | Out-Null
        }
    }

    # Remove the legacy nested install layout (invisible to VS Code prompt discovery).
    $legacyRoot = Join-Path $promptsRoot $legacyFolderName
    if (Test-Path -Path $legacyRoot) {
        if ($PSCmdlet.ShouldProcess($legacyRoot, 'Remove legacy nested install folder')) {
            Remove-Item -Path $legacyRoot -Recurse -Force
        }
    }

    $previouslyInstalled = @()
    if (Test-Path -Path $manifestPath) {
        $previouslyInstalled = @((Get-Content -Path $manifestPath -Raw | ConvertFrom-Json).files)
    }

    $installedNames = @()
    foreach ($file in $sourcePromptFiles) {
        $destinationPath = Join-Path $promptsRoot $file.Name

        if ((Test-Path -Path $destinationPath) -and ($file.Name -notin $previouslyInstalled)) {
            Write-Warning "Overwriting existing prompt file not previously installed by this library: $destinationPath"
        }

        if ($PSCmdlet.ShouldProcess($destinationPath, 'Copy prompt file')) {
            Copy-Item -Path $file.FullName -Destination $destinationPath -Force
        }

        $installedNames += $file.Name
    }

    if ($PruneStale) {
        $removedCount = 0
        foreach ($staleName in ($previouslyInstalled | Where-Object { $_ -notin $installedNames })) {
            $stalePath = Join-Path $promptsRoot $staleName
            if (Test-Path -Path $stalePath) {
                if ($PSCmdlet.ShouldProcess($stalePath, 'Remove stale prompt file')) {
                    Remove-Item -Path $stalePath -Force
                    $removedCount++
                }
            }
        }
        Write-Output ("[{0}] Pruned {1} stale prompt file(s)." -f $target.Channel, $removedCount)
    }

    if ($PSCmdlet.ShouldProcess($manifestPath, 'Write install manifest')) {
        [pscustomobject]@{
            installedAt = (Get-Date).ToString('o')
            source      = $SourceRoot
            files       = $installedNames
        } | ConvertTo-Json | Set-Content -Path $manifestPath -Encoding utf8
    }

    Write-Output ("[{0}] Installed {1} prompt(s) to: {2}" -f $target.Channel, $installedNames.Count, $promptsRoot)
}
