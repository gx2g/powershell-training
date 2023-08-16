# https://techbloggingfool.com/2021/07/24/powershell-remove-offline-network-printers-from-all-workstations/

$OfflinePrinters = Get-Printer | Where {($_.Type -like "Connection") -and ($_.PrinterStatus -notlike "Online")}|
Select Name -ExpandProperty Name;

# Foreach ($OfflinePrinter in $OfflinePrinters) {
#    Remove-Printer -Name $OfflinePrinter.Name -Confirm $False
# }

Function Remove-Printers {
    $OfflinePrinters = Get-Printer | Where-Object {($_.Type -like "Connection") -and ($_.PrinterStatus -notlike "Normal")}|
    Select-Object Name -ExpandProperty Name
Foreach ($OfflinePrinter in $OfflinePrinters) {
    Remove-Printer -Name $OfflinePrinter.Name -Confirm $false
    }
}
$Computers = Get-ADComputer -Filter ‘Operatingsystem -Notlike “*server*” -and enabled -eq “true”‘|
Select-Object dnshostname -ExpandProperty dnshostname

ForEach ($Computer in $Computers){
    Invoke-Command -ComputerName $Computer -ScriptBlock {Remove-Printers}
}


#######

dism.exe /Online /Get-Drivers

Get-WmiObject -Class Win32_Printer 

dism.exe /online /Get-DriverInfo /Driver:C:\Windows\System32\DriverStore\FileRepository\oemsetup.inf_amd64_49e52fcb140357e9\oemsetup.inf

$OfflinePrinters = Get-Printer | Where {($_.Type -like "Connection") -and ($_.PrinterStatus -notlike "Online") -and ($_.Published -like "False")}
$OfflinePrinters;


$OfflinePrinters = Get-Printer | Select Name, PrinterStatus;

#####