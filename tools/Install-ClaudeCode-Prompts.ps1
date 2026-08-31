<#
.SYNOPSIS
Installs the library's *.prompt.md files as Claude Code user-level slash commands.

.DESCRIPTION
Copies every *.prompt.md file (excluding 99-archive unless -IncludeArchive) into a
dedicated Claude Code commands subfolder (~/.claude/commands/prompt-library by default).
Each file becomes a slash command named after its lowercased filename, e.g.
Coding-Implement-Now.prompt.md -> /coding-implement-now.

The subfolder belongs entirely to this library, so -PruneStale and the uninstaller
never touch commands the user created elsewhere.

.EXAMPLE
pwsh -NoProfile -File .\tools\Install-ClaudeCode-Prompts.ps1 -PruneStale
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter()]
    [string]$SourceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path,

    [Parameter()]
    [string]$CommandRoot = (Join-Path $HOME '.claude\commands\prompt-library'),

    [Parameter()]
    [switch]$IncludeArchive,

    [Parameter()]
    [Alias('Sync')]
    [switch]$PruneStale
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

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

function Get-CommandFileName {
    param(
        [Parameter(Mandatory)]
        [string]$PromptFileName
    )

    # Coding-Implement-Now.prompt.md -> coding-implement-now.md
    return ($PromptFileName -replace '\.prompt\.md$', '.md').ToLowerInvariant()
}

$commandNames = @($sourcePromptFiles | ForEach-Object { Get-CommandFileName -PromptFileName $_.Name })
$duplicateNames = @($commandNames | Group-Object | Where-Object { $_.Count -gt 1 })
if ($duplicateNames.Count -gt 0) {
    throw "Duplicate command names after lowercasing (rename the source files): $($duplicateNames.Name -join ', ')"
}

if (-not (Test-Path -Path $CommandRoot)) {
    if ($PSCmdlet.ShouldProcess($CommandRoot, 'Create Claude Code commands directory')) {
        New-Item -Path $CommandRoot -ItemType Directory -Force | Out-Null
    }
}

$installedNames = @()
foreach ($file in $sourcePromptFiles) {
    $commandFileName = Get-CommandFileName -PromptFileName $file.Name
    $destinationPath = Join-Path $CommandRoot $commandFileName

    if (-not ((Get-Content -Path $file.FullName -TotalCount 1) -eq '---')) {
        Write-Warning "Missing YAML frontmatter (no description will show in the picker): $($file.FullName)"
    }

    if ($PSCmdlet.ShouldProcess($destinationPath, 'Copy slash command file')) {
        Copy-Item -Path $file.FullName -Destination $destinationPath -Force
    }

    $installedNames += $commandFileName
}

if ($PruneStale -and (Test-Path -Path $CommandRoot)) {
    $removedCount = 0
    $staleFiles = @(Get-ChildItem -Path $CommandRoot -File -Filter '*.md' |
        Where-Object { $_.Name -notin $installedNames })

    foreach ($staleFile in $staleFiles) {
        if ($PSCmdlet.ShouldProcess($staleFile.FullName, 'Remove stale slash command file')) {
            Remove-Item -Path $staleFile.FullName -Force
            $removedCount++
        }
    }

    Write-Output ("Pruned {0} stale command(s) from: {1}" -f $removedCount, $CommandRoot)
}

Write-Output ("Installed {0} slash command(s) to: {1}" -f $installedNames.Count, $CommandRoot)
Write-Output 'Available in Claude Code chat as:'
foreach ($name in ($installedNames | Sort-Object)) {
    Write-Output ("  /{0}" -f ($name -replace '\.md$', ''))
}
