Function Connect-ExchangeOnline {
    $office365Credential = Get-Credential
    $global:office365 = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $office365Credential  -Authentication Basic   –AllowRedirection
    Import-PSSession $office365
    }
    
    Function Disconnect-ExchangeOnline {
    Get-PSSession | Where-Object {$_.ConfigurationName -eq “Microsoft.Exchange”} | Remove-PSSession
    }