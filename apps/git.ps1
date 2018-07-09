# install latest git
cd $HOME\Downloads\

$gitInf = @'
[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=0
SetupType=default
Components=ext,ext\shellhere,gitlfs,assoc,assoc_sh
Tasks=
EditorOption=VIM
PathOption=Cmd
SSHOption=OpenSSH
CURLOption=OpenSSL
CRLFOption=LFOnly
BashTerminalOption=MinTTY
PerformanceTweaksFSCache=Enabled
UseCredentialManager=Enabled
EnableSymlinks=Disabled
'@

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent: powershell")
$json = $wc.DownloadString('https://api.github.com/repos/git-for-windows/git/releases/latest')
$jsonObject = ConvertFrom-Json -InputObject $json
$gitInstaller = ''

Foreach ($asset in $jsonObject.assets) {
    if ($asset.name.endswith('-64-bit.exe')) {
        $gitInstaller = $asset.name
        $wc.DownloadFile($asset.browser_download_url, (Get-Item -Path '.\').FullName + '\' + $gitInstaller)
        $gitInf | Out-File git.INF
        cmd /C $gitInstaller /VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS '/LOADINF="git.INF"'
        rm git.INF
        rm $gitInstaller
        break
    }
}

if ($gitFound::IsNullOrEmpty) {
    echo 'Git not installed!'
}
