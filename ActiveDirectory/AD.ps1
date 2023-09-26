# Getting AD Information
Get-ADDomain;

# Simple Test to edit the discription of an AD User
Set-ADUser username -Description 'Sales Team Member';


# Find AD Group
Get-ADGroup -filter * | sort name | select Name

# Use Get-ADGroupMember to list group members
Get-ADGroupMember -identity "GroupName" | format-list 

# Use Get-ADGroupMember to list group members clean
Get-ADGroupMember -identity "GroupName" | format-table