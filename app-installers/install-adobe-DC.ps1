<#
    #After download remove Zone Identifier to unlock file
    Unblock-File -Path "C:\Windows\Temp\ArcoRdrDC2200320322_en_US.exe"
#>

$Options = @('/sAll','/rs','/msi')

# Start-Process "Run as administrator"
Start-Process -Wait -FilePath 'C:\Windows\Temp\AcroRdrDC2200320322_en_US.exe' -ArgumentList $Options -Verb RunAs -PassThru
