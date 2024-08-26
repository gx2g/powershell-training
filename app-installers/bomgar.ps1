$DownloadPath = "%windir%\Temp\bomgar-scc-win64.msi"

# make sure to add key in KEY INFO
$ArgumentsMSI = '/i ' + '"' + "$DownloadPath" + '" ' + '/quiet ' + 'KEY_INFO=<add key here>'

# 'Output arguments and verify first'
Write-Host $ArgumentsMSI

# 'Only run after verifying output of resulting $ArgumentsMSI first'
# 'Start-Process -FilePath "msiexec.exe" -Wait -ArgumentList $ArgumentsMSI'