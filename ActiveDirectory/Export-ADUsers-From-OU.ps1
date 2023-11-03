$OU = 'OU=Accounts Employees,OU=CTE - Users,DC=CTE,DC=local'
# Use Get-AdUser to search within organizational unit to get users name
Get-ADUser -Filter * -SearchBase $OU | Select-object DistinguishedName,Name,UserPrincipalName | Export-Csv -path 'C:\users\Admin\Desktop\CTE-Employee-List-csv' -NoTypeInformation