# Gets one or more Active Directory managed service accounts or group managed service accounts.

Get-ADServiceAccount -Filter { HostComputers -eq "CN=Rev-DC-01, DC=revchem, DC=com" }

# Get specifics for a module, cmdlet, or function
(Get-Command -Name Get-ADServiceAccount).Parameters
# Get specifics for a module, cmdlet, or function just keys only
(Get-Command -Name Get-ADServiceAccount).Parameters.Keys

# Get All Services
Get-WmiObject -Class Win32_Service -ComputerName $env:ComputerName | Select-Object -Property DisplayName, StartName, State

# Filter for type
Get-WmiObject -Class Win32_Service -ComputerName $env:ComputerName | Where-Object { $PSItem.StartName -match 'localSystem' } | Select-Object -Property DisplayName, StartName, State

# Get Service Accounts on Single Computer
Get-WmiObject win32_service -comp <ComputerNameHere> | Group StartName -NoElement

# If you don't want to Group results
Get-Wmiobject win32_service -comp <ComputerNameHere> | Select Name, Status, Startname

# wildcard search for service accounts running as a domain user
Get-WmiObject Win32_Service -Comp <ComputerNameHere> -filter "startname like '%activedirectory%' " | Select Name, Status, StartName