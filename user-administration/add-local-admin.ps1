$Username = ""
$Password = ""

$LocGroup = "Administrators"

$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"

$existing = $adsi.Cildren | where {$_.SchemaClassName}

