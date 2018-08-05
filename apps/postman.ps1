# install latest postman
cd $HOME\Downloads\

$webClient = new-object System.Net.WebClient
$data = $webClient.DownloadData('https://dl.pstmn.io/download/latest/win64')
$contentDisposition = $webClient.ResponseHeaders["Content-Disposition"]
$postmanInstaller = If ([string]::IsNullOrEmpty($contentDisposition)) {"postman-win64-latest.exe"} Else {$contentDisposition.Substring($contentDisposition.IndexOf("filename=") + 9).Replace('"', '')}

# write to file
[IO.File]::WriteAllBytes((Get-Item -Path '.\').FullName + '\' + $postmanInstaller, $data)

cmd /C $postmanInstaller
rm $postmanInstaller
