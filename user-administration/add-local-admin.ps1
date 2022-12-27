$Username = "userNameHere"
$Password = "Password Here"

$LocGroup = "Administrators"

$adsi = [ADSI]"WinNT://$env:COMPUTERNAME"

$existing = $adsi.Children | where { $_.SchemaClassName -eq 'user' -and $_.Name -eq $Username }

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