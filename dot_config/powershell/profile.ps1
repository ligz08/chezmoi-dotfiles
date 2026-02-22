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

# starship prompt
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
Invoke-Expression (&starship init powershell)
