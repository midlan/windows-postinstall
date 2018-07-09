# install latest fusion 360
cd $HOME\Downloads\

(new-object System.Net.WebClient).DownloadFile('https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Client%20Downloader.exe', (Get-Item -Path '.\').FullName + '\Fusion360ClientDownloader.exe')
# don't know silent options, some user action may be required
cmd /C Fusion360ClientDownloader.exe
rm Fusion360ClientDownloader.exe
