$u = New-Object -ComObject Microsoft.Update.Session
$u.ClientApplicationID = 'Powershell Script to check for Available Updates'
$s = $u.CreateUpdateSearcher()
$r = $s.Search("IsInstalled=0 and Type='Software' and IsHidden=0")
$r.updates | Select-Object -ExpandProperty Title