# PDC emulator role is in charge of gpupdate by the domain controller

# Get the Default Domain password policy 

Import-Module ActiveDirectory 


get-addomain | get-adobject -properties * | select *pwd*

# in most cases the output will match with whats in the Default Domain Policy. 
Get-ADDefaultDomainPasswordPolicy

# If more then one GPO for Password Reset Policy then the LINK ORDER takes precedence. 


# You can use PowerShell to set the minimum password length using the following: 
Set-ADDefaultDomainPasswordPolicy -Identity "domain.com" -MinPasswordLength 10

# Set the minimum password age with the following PowerShell code: 
Set-ADDefaultDomainPasswordPolicy -Identity "domain.com" -MinPasswordAge 2.00:00:00 



<#
Fine-Grained Password Policies

In Windows 2008 Microsoft introduced the Fine-Grained Password Policies (FGPP) feature, 
enabling administrators to configure different password policies based on Active Directory security groups.

To create or view fine-grained password policies, you can use ADSIEdit, PowerShell, or the 
Active Directory Administrative Center.
#>

get-adfinegrainedpasswordpolicy -filter *

# The cmdlet New-ADFineGrainedPasswordPolicy is used to create new Active Directory fine grained password policies. 

#  changing the minimum password length, gave the policy a name and assigned it precedence 1. 
New-ADFineGrainedPasswordPolicy -name "Server-Admins-Policy" -Precedence 1 -MinPasswordLength 15

# Now that the policy is created it needs to be assigned to users or a group.
Add-ADFineGrainedPasswordPolicySubject -Identity "Server-Admins-Policy" -Subjects "server-admins"

# -identity is the name of the policy and -subject is the name of the group or user you want the policy assigned to. 

# Create a new PSO 
New-ADFineGrainedPasswordPolicy -Name "TestPasswordPolicy" -Precedence 500 -ComplexityEnabled $true -ReversibleEncryptionEnabled $false -MinPasswordLength 8 -PasswordHistoryCount 24 -MaxPasswordAge (New-TimeSpan -Days 60) -MinPasswordAge (New-TimeSpan -Days 1) -LockoutThreshold 5 -LockoutObservationWindow (New-TimeSpan -Minutes 30) -LockoutDuration (New-TimeSpan -Minutes 30)

<# 
This command above creates a new PSO with the following settings: 

Name: TestPasswordPolicy 
Precedence: 500 
Password complexity: Enabled 
Reversible encryption: Disabled 
Minimum password length: 8 characters 
Password history count: The last 24 passwords 
Maximum password age: 60 days 
Minimum password age: 1 day 
Account lockout threshold: 5 failed logon attempts 
Lockout observation window: 30 minutes 
Lockout duration: 30 minutes 

#>


