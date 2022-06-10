# Enabling Cloud Achriving in Hybrid configuration On-Premise to 365

#########
# Use the Exchange Management Shell to create a 
# cloud-based archive mailbox for a new user
#########

# The following example creates a new primary on-premises mailbox and Active Directory user account for Pilar Pinilla with a cloud-based archive mailbox:
# Note: don't forget ot change tenant_domain to company domain for tenant after -ArchiveDomain
New-Mailbox -Name "Pilar Pinilla" -UserPrincipalName pilarp@contoso.com -Password (ConvertTo-SecureString -String 'Pa$$word1' -AsPlainText -Force) -ArchiveDomain "tenant_domain.mail.onmicrosoft.com" -RemoteArchive -FirstName Pilar -LastName Pinilla

# The following example creates a new primary online mailbox and Active Directory user account for Kim Akers with a cloud-based archive mailbox:
New-RemoteMailbox -Name "Kim Akers" -UserPrincipalName kima@contoso.com -Password (ConvertTo-SecureString -String 'Pa$$word1' -AsPlainText -Force) -Archive -FirstName Kim -LastName Akers

#########
# Use the Exchange Management Shell to create a 
# cloud-based archive mailbox for an existing user
#########

# The following example creates a cloud-based archive mailbox for Ayla who has a primary on-premises mailbox:
Enable-Mailbox -Identity ayla@contoso.com -RemoteArchive -ArchiveDomain "contoso.mail.onmicrosoft.com"

# The following example creates a cloud-based archive mailbox for Laura who has a primary online mailbox:
Enable-RemoteMailbox -Identity laura@contoso.com -Archive
