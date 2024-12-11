Install-Module -Name ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Get-ExecutionPolicy

Connect-ExchangeOnline -UserPrincipalName user@domain.com

# Get-Mailbox -ResultSize Unlimited | select Name, RecipientTypeDetails



