$execPolicy = Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned -Force
Install-PackageProvider -Name NuGet -Force
Install-Module posh-docker -Force

if (-Not (Test-Path $PROFILE)) {
    New-Item $PROFILE –Type File –Force
}

Add-Content $PROFILE "`nImport-Module posh-docker"
Import-Module posh-docker
Set-ExecutionPolicy $execPolicy -Force
