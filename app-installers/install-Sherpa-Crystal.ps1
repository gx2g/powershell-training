$Options = @('/n','/norestart','/quiet')

# Start-Process "Run as administrator"
Start-Process -Wait -FilePath 'C:\Windows\Temp\CRRuntime_32bit_13_0.msi' -ArgumentList $Options -Verb RunAs -PassThru