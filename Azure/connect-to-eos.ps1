
# Check if module is installed
$null -ne (Get-Module -ListAvailable -Name ExchangeOnlineManagement)

# Check if WinRM Service is active 
Get-Item WSMan:\localhost\Shell\AllowRemoteShellAccess
