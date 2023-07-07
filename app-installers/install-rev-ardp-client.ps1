# $pkg = "%windir%\Temp\revchem-ardp-client.msi";
# Start-Process msiexec "/i $pkg /norestart /qn" -Wait;
Start-Process msiexec.exe -Wait -ArgumentList '/I C:\Windows\Temp\revchem-ardp-client.msi /NORESTART /QN'