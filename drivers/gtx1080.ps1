# install latest gtx1080 drivers
cd $HOME\Downloads\

Add-Type -AssemblyName System.Web

$webClient = new-object System.Net.WebClient

# psid=101 means searies; geforce 10 series
# pfid=815 means family; GTX 1080
# rpf=1 is set always
# osid=57 means win 10 64-bit
# lid=1 means english (us) language
# ctk=0 means cuda toolkit version

$url = $webClient.DownloadString('http://www.nvidia.com/Download/processDriver.aspx?psid=101&pfid=815&rpf=1&osid=57&lid=1&lang=en-us&ctk=0').Trim()
$urlObject = [System.Uri]$url
$urlOrigin = $urlObject.GetComponents([System.UriComponents]::SchemeAndServer, [System.UriFormat]::SafeUnescaped)

$html = (New-Object System.Net.WebClient).DownloadString($url)
$htmlObject = New-Object -Com "HTMLFile"
$htmlObject.write([System.Text.Encoding]::Unicode.GetBytes($html))

Foreach ($link in $htmlObject.links) {

    if ($link.id -eq 'lnkDwnldBtn') {

        $downloadUrl = $link.href.Replace('about:', '')

        #absolute url
        if ($downloadUrl.StartsWith('/')) {
            $downloadUrl = $urlOrigin + $downloadUrl
        }
        #relative url
        else {
            
            $urlSegments = $urlObject.Segments
            $relative = $urlOrigin

            for($($i = 0; $max = $urlSegments.Count - 1); $i -lt $max; $i++) {
                $relative += $urlSegments[$i]
            }

            $downloadUrl = $relative + $downloadUrl
        }

        $downloadUrlObject = [System.Uri]$downloadUrl
        $query = [System.Web.HttpUtility]::ParseQueryString($downloadUrlObject.Query)
        
        # skip license page and build direct download link
        $finalUrl = 'http://' + $query['lang'] + '.download.nvidia.com' + $query['url']
        $finalUrlSegments = ([System.Uri]$finalUrl).Segments
        $driverInstaller = $finalUrlSegments[$finalUrlSegments.Count - 1]
        
        (new-object System.Net.WebClient).DownloadFile($finalUrl, (Get-Item -Path '.\').FullName + '\' + $driverInstaller)
        cmd /C $driverInstaller /S
        rm $driverInstaller
        break

        #todo silent install https://lazyadmin.nl/it/deploy-nvidia-drivers/
    }
}
