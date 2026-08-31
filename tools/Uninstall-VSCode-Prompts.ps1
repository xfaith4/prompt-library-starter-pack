[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter()]
    [ValidateSet('Stable', 'Insiders', 'Both')]
    [string]$Channel = 'Stable'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$targetRoots = @()

if ($Channel -eq 'Stable' -or $Channel -eq 'Both') {
    $targetRoots += Join-Path $env:APPDATA 'Code\User\prompts\prompt-library-starter-pack'
}

if ($Channel -eq 'Insiders' -or $Channel -eq 'Both') {
    $targetRoots += Join-Path $env:APPDATA 'Code - Insiders\User\prompts\prompt-library-starter-pack'
}

foreach ($targetRoot in $targetRoots) {
    if (Test-Path -Path $targetRoot) {
        if ($PSCmdlet.ShouldProcess($targetRoot, 'Remove installed prompt library directory')) {
            Remove-Item -Path $targetRoot -Recurse -Force
            Write-Output "Removed: $targetRoot"
        }
    }
    else {
        Write-Output "Not found (nothing to remove): $targetRoot"
    }
}
