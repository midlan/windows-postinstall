# hide mouse cursor while typing
$upmcu = (Get-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Control Panel\Desktop")."UserPreferencesMask"
$upmcu[2] = $upmcu[2] -bor 0x1
Set-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Control Panel\Desktop" -Name "UserPreferencesMask" -Value $upmcu
