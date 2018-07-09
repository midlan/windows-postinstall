# disable desktop preview when hover desktop button on taskbar (currently disabled by default on win10)
REG.exe ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisablePreviewDesktop /t REG_DWORD /d 1 /f
