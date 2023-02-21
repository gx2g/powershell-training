# Create a password object
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Module.$PasswordProfile

# Assign the password
$PasswordProfile.Password = "<Password>"

# Create the new user
New-AzureADUser -AccountEnabled $true -DisplayName "Joe Doe" -PasswordProfile $PasswordProfile -MailNickName "JohnD" -UserPrincipalName "johnd@contos.com"