# Check Computer Name and Add Computer to domain
$cbeCompName = $env:COMPUTERNAME;
Add-Computer -ComputerName $cbeCompName -localCredentail $cbeCompName/admin01 -DomainName domain.local -Credentail domain\Admin02 =Restart -Force