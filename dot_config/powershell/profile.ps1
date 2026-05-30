# print OS and PS info
$arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
if ($IsWindows) {
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    Write-Host "Operating system: $($os.OSArchitecture) $($os.Caption) $($os.Version)"
} elseif ($IsLinux) {
    $pretty = (Get-Content /etc/os-release | ConvertFrom-StringData).PRETTY_NAME.Trim('"')
    Write-Host "Operating system: $arch $pretty $(uname -r)"
} elseif ($IsMacOS) {
    Write-Host "Operating system: $arch $(sw_vers -productName) $(sw_vers -productVersion)"
}
Write-Host "PowerShell version: $($PSVersionTable.PSVersion)"

# display current folder name as window/tab title
function Set-WindowTitle {
    $uiTitle = $PWD | Convert-Path | Split-Path -Leaf
    $Host.UI.RawUI.WindowTitle = $uiTitle
}
$ExecutionContext.InvokeCommand.LocationChangedAction = { Set-WindowTitle }
Set-WindowTitle

# run ps*.ps1 in this directory
Join-Path $PSScriptRoot 'ps*.ps1' | Get-ChildItem | ForEach-Object {. $_.FullName}

# starship prompt
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship\starship.toml"
Invoke-Expression (&starship init powershell)
