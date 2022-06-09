# Use Test WSMan IP address to see if all is working
Test-WSMan "IP ADDRESS"

# Ruen WinRM on both machines to confirm local access is setup. 
# winrm help config

# WinRM quick config will tell you want to do. 
# winrm quickconfig

# set the ip address to trust from each others IP
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "IP Address"
# Check on both machines that they are added to this TrustHosts for communication
Get-Item WSMan:\localhost\Client\TrustedHosts

# Enter PSSession to remote computer and sign in. 
Enter-PSSession -ComputerName "IP ADDRESS" -Credential $Credentials 

Get-NetFirewallRule -Name "WINRM*" | Select-Object Name

Get-NetConnectionProfile