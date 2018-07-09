# install latest vlc
cd $HOME\Downloads\

$latest = (New-Object System.Net.WebClient).DownloadString('http://update.videolan.org/vlc/status-win-x64')
$latestUrl = ($latest -split '\n')[1]
$urlObject = [System.Uri]$latestUrl
$vlcInstaller = [io.path]::GetFileName($urlObject.LocalPath)
(new-object System.Net.WebClient).DownloadFile($latestUrl, (Get-Item -Path '.\').FullName + '\' + $vlcInstaller)
cmd /C $vlcInstaller # todo silent install
rm $vlcInstaller
