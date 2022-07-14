Set-ExecutionPolicy Unrestricted -Force

$office365Credential = Get-Credential

$global:office365= New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $office365Credential -Authentication Basic -AllowRedirection

Import-PSSession $office365

#### if you get an access denied message, read link to resolve issue. Security Defaults
#### https://docs.microsoft.com/en-us/exchange/troubleshoot/administration/access-denied-connect-powershell

======================================================

Get-DistributionGroup

Get-DistributionGroup -Identity "WF Team" | Format-List

Get-DistributionGroupMember -Identity "WF Team"

$DGName = "WF Team"

Get-DistributionGroupMember -Identity $DGName | Select-Object Name, PrimarySMTPAddress | Export-CSV "C:\Distribution-List-Members.csv" -NoTypeInformation -Encoding UTF8