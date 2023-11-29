# Reset an AD User Password

Set-ADAccountPassword -Identity AbbeyCrawford
Set-ADAccountPassword -Identity "CN=AbbeyCrawford,OU=VersaCorp,DC=milkyway,DC=local"

# prompt will show in concole to enter old password and then ask for new password. 

$Pwd = ConvertTo-SecureString "MyNewPassword@123" -AsPlainText -Force Set-ADAccountPassword -Identity AbbeyWarren -NewPassword $Pwd -Reset

# Running these cmdlets will not show any output in the PowerShell console.

# Add -PassThru to get output feedback
Set-ADAccountPassword abbeywarren -Reset -NewPassword (ConvertTo-SecureString -AsPlainText “NewP@ssw0rd123” -Force -Verbose) –PassThru

# Unlock account while resetting password with Unlock-ADAccount
Set-ADAccountPassword abbeywarren -Reset –NewPassword $PWD –PassThru | Unlock-ADAccount

# Force the User to Change Password at Next Logon

Set-ADUser -Identity abbeywarren -ChangePasswordAtLogon $true

# Change Users password and have them reset at next logon. 
Set-ADAccountPassword abbeycrawford -NewPassword $Pwd -Reset -PassThru | Set-ADuser -ChangePasswordAtLogon $True
