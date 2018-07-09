# install latest adobe reader
cd $HOME\Downloads\

(new-object System.Net.WebClient).DownloadFile('https://admdownload.adobe.com/bin/live/readerdc_cz_xa_crd_install.exe', (Get-Item -Path '.\').FullName + '\readerdc_cz_xa_crd_install.exe')
# don't know silent options, some user action may be required
cmd /C readerdc_cz_xa_crd_install.exe
rm readerdc_cz_xa_crd_install.exe
