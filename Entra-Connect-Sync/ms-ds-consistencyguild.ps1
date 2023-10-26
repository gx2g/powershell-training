

# Microsoft Entra Connect Sync must be installed in order to check 

Get-ADObject -Ldapfilter "(mS-DS-ConsistencyGUID=*)" | Export-CSV c:\ms-ds-consistencyGUID.csv -NoTypeInformation

Get-ADUser -Filter * -Properties CN,mS-DS-ConsistencyGuid | Where-Object {$_.'mS-DS-ConsistencyGuid' -ne $null} | Select-Object CN,SamAccountName,mS-DS-ConsistencyGuid

$User = Get-ADUser -Identity rresendez -Properties mS-DS-ConsistencyGILD
$User.ObjectGUID



Invoke-WebRequest -Uri https://adminwebservice.microsoftonline.com/ProvisioningService.svc