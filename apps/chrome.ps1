# install latest chrome
cd $HOME\Downloads\

(new-object System.Net.WebClient).DownloadFile('https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B9077E192-1512-6814-2391-D79F39931F5D%7D%26lang%3Dcs%26browser%3D5%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Ddefaultbrowser/update2/installers/ChromeSetup.exe', (Get-Item -Path '.\').FullName + '\ChromeSetup.exe')
cmd /C ChromeSetup.exe
rm ChromeSetup.exe
