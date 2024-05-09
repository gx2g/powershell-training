# PDC emulator role is in charge of gpupdate by the domain controller

get-addomain | get-adobject -properties * | select *pwd*

# in most cases the output will match with whats in the Default Domain Policy. 
Get-ADDefaultDomainPasswordPolicy

# If more then one GPO for Password Reset Policy then the LINK ORDER takes precedence. 



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