# Reset an AD User Password

Set-ADAccountPassword -Identity AbbeyCrawford
Set-ADAccountPassword -Identity "CN=AbbeyCrawford,OU=VersaCorp,DC=milkyway,DC=local"

# prompt will show in concole to enter old password and then ask for new password. 

$Pwd = ConvertTo-SecureString "MyNewPassword@123" -AsPlainText -Force Set-ADAccountPassword -Identity AbbeyWarren -NewPassword $Pwd -Reset

# Running these cmdlets will not show any output in the PowerShell console.

# Add -PassThru to get output feedback
Set-ADAccountPassword maguila -Reset -NewPassword (ConvertTo-SecureString -AsPlainText “NewPassHere” -Force -Verbose) –PassThru

# Unlock account while resetting password with Unlock-ADAccount
Set-ADAccountPassword abbeywarren -Reset –NewPassword $PWD –PassThru | Unlock-ADAccount

# Force the User to Change Password at Next Logon

Set-ADUser -Identity abbeywarren -ChangePasswordAtLogon $true

# Change Users password and have them reset at next logon. 
Set-ADAccountPassword abbeycrawford -NewPassword $Pwd -Reset -PassThru | Set-ADuser -ChangePasswordAtLogon $True

# Reset a Password using Alternative Credentail

# First, store your admin credentials in a variable
$Credentials = Get-Credential

# Prompt will open up to provide those admin creds. 

# Store the new password for user in variable 
$Pwd = ConvertTo-SecureString "MyNewPassword@123" -AsPlainText -Force

# Then we use both these variables in Set-ADAccountPassword:

Set-ADAccountPassword -Identity abbeywarren -NewPassword $Pwd -Credential $Credential

# Verify Password Reset Results

Get-ADUser abbeywarren -Properties * | select name, pass*

# Reset Passwords for Multiple Users to the Same Value

Get-ADUser -filter "department -eq 'Engineering'" | Set-ADAccountPassword -NewPassword $Pwd -Reset -PassThru | Set-ADuser -ChangePasswordAtLogon $True

# Verify the results 

Get-ADUser -filter "department -eq 'Engineering'" -Properties * | select name, pass*

# Reset Passwords for Multiple Users to Different Value

Import-Csv c:\temp\users_new_passwords.csv -Delimiter "," | Foreach {

    $NewPassword = ConvertTo-SecureString -AsPlainText $_.NewPassword -Force
    
    Set-ADAccountPassword -Identity $_.sAMAccountName -NewPassword $NewPassword -Reset -PassThru | Set-ADUser -ChangePasswordAtLogon $false
    
}



######

Set-MsolUserPassword -UserPrincipalName "user@email.com" -NewPassword "newPassHere"

######