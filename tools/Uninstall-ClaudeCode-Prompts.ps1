<#
.SYNOPSIS
Removes the Claude Code slash commands this library installed.

.DESCRIPTION
Deletes the dedicated commands subfolder (~/.claude/commands/prompt-library by default).
That folder is created and owned exclusively by Install-ClaudeCode-Prompts.ps1, so
commands the user created elsewhere are never touched.

.EXAMPLE
pwsh -NoProfile -File .\tools\Uninstall-ClaudeCode-Prompts.ps1
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter()]
    [string]$CommandRoot = (Join-Path $HOME '.claude\commands\prompt-library')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (Test-Path -Path $CommandRoot) {
    if ($PSCmdlet.ShouldProcess($CommandRoot, 'Remove installed Claude Code commands directory')) {
        Remove-Item -Path $CommandRoot -Recurse -Force
        Write-Output "Removed: $CommandRoot"
    }
}
else {
    Write-Output "Not found (nothing to remove): $CommandRoot"
}
