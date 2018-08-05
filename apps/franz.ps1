# install latest franz
cd $HOME\Downloads\

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent: powershell")
$json = $wc.DownloadString('https://api.github.com/repos/meetfranz/franz/releases/latest')
$jsonObject = ConvertFrom-Json -InputObject $json
$franzInstaller = ''

Foreach ($asset in $jsonObject.assets) {
    
    if ($asset.name.endswith('.exe')) {
        $franzInstaller = $asset.name
        $wc.DownloadFile($asset.browser_download_url, (Get-Item -Path '.\').FullName + '\' + $franzInstaller)
        cmd /C $franzInstaller /s
        rm $franzInstaller
        break
    }
}
