# install latest docker
cd $HOME\Downloads\

(new-object System.Net.WebClient).DownloadFile('https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe', (Get-Item -Path '.\').FullName + '\DockerforWindowsInstaller.exe')
cmd /C DockerforWindowsInstaller.exe
rm DockerforWindowsInstaller.exe
