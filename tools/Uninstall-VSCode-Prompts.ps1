<#
.SYNOPSIS
Removes the prompt files this library installed into VS Code (Copilot Chat).

.DESCRIPTION
Reads the install manifest (prompt-library-starter-pack.manifest.json) in the VS Code
user prompts folder and removes only the files listed there, plus the manifest itself
and any legacy nested install folder. Prompt files the user created independently are
never touched.

.EXAMPLE
pwsh -NoProfile -File .\tools\Uninstall-VSCode-Prompts.ps1 -Channel Both
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter()]
    [ValidateSet('Stable', 'Insiders', 'Both')]
    [string]$Channel = 'Stable'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$manifestFileName = 'prompt-library-starter-pack.manifest.json'
$legacyFolderName = 'prompt-library-starter-pack'

$promptsRoots = @()

if ($Channel -in @('Stable', 'Both')) {
    $promptsRoots += Join-Path $env:APPDATA 'Code\User\prompts'
}

if ($Channel -in @('Insiders', 'Both')) {
    $promptsRoots += Join-Path $env:APPDATA 'Code - Insiders\User\prompts'
}

foreach ($promptsRoot in $promptsRoots) {
    $removedCount = 0

    $legacyRoot = Join-Path $promptsRoot $legacyFolderName
    if (Test-Path -Path $legacyRoot) {
        if ($PSCmdlet.ShouldProcess($legacyRoot, 'Remove legacy nested install folder')) {
            Remove-Item -Path $legacyRoot -Recurse -Force
        }
    }

    $manifestPath = Join-Path $promptsRoot $manifestFileName
    if (-not (Test-Path -Path $manifestPath)) {
        Write-Output "No install manifest found (nothing to remove): $promptsRoot"
        continue
    }

    $installedFiles = @((Get-Content -Path $manifestPath -Raw | ConvertFrom-Json).files)

    foreach ($fileName in $installedFiles) {
        $filePath = Join-Path $promptsRoot $fileName
        if (Test-Path -Path $filePath) {
            if ($PSCmdlet.ShouldProcess($filePath, 'Remove installed prompt file')) {
                Remove-Item -Path $filePath -Force
                $removedCount++
            }
        }
    }

    if ($PSCmdlet.ShouldProcess($manifestPath, 'Remove install manifest')) {
        Remove-Item -Path $manifestPath -Force
    }

    Write-Output ("Removed {0} prompt file(s) from: {1}" -f $removedCount, $promptsRoot)
}
