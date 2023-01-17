Install-Module -Name AzureAD
Connect-AzureAD

$PasswordProfile = New-Object -TypeName
Microsoft.Open.AzureAD.Model.$PasswordProfile
$PasswordProfile.Password = "P@ssw0rd8!"
$PasswordProfile.EnforceChangePasswordPolicy = $true

New-AzureADUser -DisplayName "The Users Name" -PasswordProfile $PasswordProfile -UserPrincipalName "user@domain.com" -AccountEnabled $true

