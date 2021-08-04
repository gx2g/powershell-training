Function Disconnect-ExchangeOnline {
Get-PSSession | Where-Object {$_.ConfigurationName -eq “Microsoft.Exchange”} | Remove-PSSession
}