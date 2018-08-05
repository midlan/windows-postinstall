# install latest 7zip
cd $HOME\Downloads\

$7zUrl = 'https://7-zip.org/download.html'
$urlObject = [System.Uri]$7zUrl
$urlOrigin = $urlObject.GetComponents([System.UriComponents]::SchemeAndServer, [System.UriFormat]::SafeUnescaped)

$html = (New-Object System.Net.WebClient).DownloadString($7zUrl)
$htmlObject = New-Object -Com "HTMLFile"
$htmlObject.write([System.Text.Encoding]::Unicode.GetBytes($html))

Foreach ($link in $htmlObject.links) {
    if ($link.textContent -eq 'Download' -and $link.pathname.endswith('-x64.exe')) {
        $downloadUrl = $link.href.Replace('about:', $urlOrigin)
        $7zInstaller = $link.nameProp
        (new-object System.Net.WebClient).DownloadFile($downloadUrl, (Get-Item -Path '.\').FullName + '\' + $7zInstaller)
        cmd /C $7zInstaller /S
        rm $7zInstaller
        break
    }
}


# create file associations
# <extension> = <icon index>
$extns = @{
    '001' = 9
    '7z' = 0
    'arj' = 4
    'bz2' = 2
    'bzip2' = 2
    'cpio' = 12
    'deb' = 11
    'dmg' = 17
    'fat' = 21
    'gz' = 14
    'gzip' = 14
    'hfs' = 18
    'lha' = 6
    'lzh' = 6
    'lzma' = 16
    'ntfs' = 22
    'rar' = 3
    'rpm' = 10
    'squashfs' = 24
    'swm' = 15
    'tar' = 13
    'taz' = 5
    'tbz' = 2
    'tbz2' = 2
    'tgz' = 14
    'tpz' = 14
    'txz' = 23
    'wim' = 15
    'xar' = 19
    'xz' = 23
    'z' = 5

    # extensions that windows can handle itself, uncomment if you want also associate them
    # 'cab' = 7
    # 'iso' = 8
    # 'vhd' = 20
    # 'zip' = 1
}

$7zDir = (Get-ItemProperty -Path "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip")."Path64"

foreach($ext in $extns.keys) {

    $iconIndex = $extns[$ext]
    $className = "7-Zip.$ext"

    $registry = @(
        @{
            Force = $true
            Path = "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.$ext"
            Name = '(Default)'
            Value = $className
        }
        @{
            Force = $true
            Path = "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$className"
            Name = '(Default)'
            Value = "$ext Archive"
        }
        @{
            Force = $true
            Path = "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$className\DefaultIcon"
            Name = '(Default)'
            Value = "${7zDir}7z.dll,$iconIndex"
        }
        @{
            Force = $true
            Path = "Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\$className\shell\open\command"
            Name = '(Default)'
            Value = """${7zDir}7zFM.exe"" ""%1"""
        }

    )

    foreach ($item in $registry) {

        if ( -not (Test-Path $item.Path)) {
            New-Item -Force -Path $item.Path;
        }
        
	    New-ItemProperty @item
    }
}
