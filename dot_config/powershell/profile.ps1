# print OS and PS info
$os = Get-CimInstance -ClassName Win32_OperatingSystem
Write-Host "Operating system: $($os.OSArchitecture) $($os.Caption) $($os.Version)"
Write-Host "PowerShell version: $($PSVersionTable.PSVersion)"

# display current folder name as window/tab title
$ExecutionContext.InvokeCommand.LocationChangedAction = {
	$uiTitle = $PWD | Convert-Path | Split-Path -Leaf
    $Host.UI.RawUI.WindowTitle = $uiTitle
}

# run ps*.ps1 in this directory
Join-Path $PSScriptRoot 'ps*.ps1' | Get-ChildItem | ForEach-Object {. $_.FullName}

# custom prompt function -- retired, to be replaced by starship
function prompt {
    $uiTitle = $PWD | Convert-Path | Split-Path -Leaf
    $Host.UI.RawUI.WindowTitle = $uiTitle
    Write-Host "`n$env:USERNAME" -ForegroundColor Green -NoNewline
    if (Test-Administrator) {
        Write-Host " as " -NoNewline
        Write-Host "Administrator" -ForegroundColor Red -NoNewline
        $Host.UI.RawUI.WindowTitle = $uiTitle + " (Administrator)"
    }
    Write-Host " at " -NoNewline
    Write-Host $env:COMPUTERNAME -ForegroundColor Magenta -NoNewline
    Write-Host " in " -NoNewline
    Write-Host $ExecutionContext.SessionState.Path.CurrentLocation -ForegroundColor Cyan -NoNewline
    $branch = try { git rev-parse --abbrev-ref HEAD 2>$null} catch {$null}
    if ($branch){
        Write-Host " on " -NoNewline
        Write-Host $branch -ForegroundColor Yellow -NoNewline
    }
    return "`nPS $('>' * ($NestedPromptLevel + 1)) "
}

# starship prompt
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
