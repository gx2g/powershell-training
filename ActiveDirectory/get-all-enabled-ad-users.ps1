Get-ADUser -Filter * -Properties mail | Where { $_.Enabled -eq $True} | Select-Object Name, samaccountname, mail, enabled | Export-CSV "C:\\all-active-ad-users.csv" -NoTypeInformation