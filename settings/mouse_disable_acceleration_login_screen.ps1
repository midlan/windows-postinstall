# disable mouse acceleration on login screen
REG.exe ADD "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f
REG.exe ADD "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f
REG.exe ADD "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f
