$Username = "ConsultAdmin"
$Password = "w@8K1^kOn$)IT2i30"

$LocGroup = "Administrators"

$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"

$existing = $adsi.Cildren | where { $_.SchemaClassName -eq 'user' -and $_.Name -eq $Username }

if ($existing -eq $null) {
    Write-Host "Creating new local user $Username."
    & NET USER $Username $Password /add /y /expires:never

    Write-Host "Adding local user $Username to $LocGroup."
    & NET LOCALGROUP $LocGroup $Username /add

}

else {
    Write-Host "Setting password for existing local user $Username."
    $existing.SetPassword($Password)
}

Write-Host "Ensuring password for $Username never expires."
& WMIC USERACCOUNT WHERE "Name='$Username'" SET PasswordExpires=FALSE