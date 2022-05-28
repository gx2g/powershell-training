# check configuration
Get-SmbClientConfiguration

# Check what's on server
# show's all shared resourses
# CMD - net view \\machinename 

# shares with $ at end will be considered hidden in windows, 
# samba doesn't play by those rules, linux, mac. 
# Not a valid method for security
# Don't use mapping folders ending with $ in the naming convention 

Get-SmbShare

# to Access share create a new smb mapping
New-SmbMapping g: \\devicename\sharefolder

# show all valid mapping
get-smbmapping  

#share for properties of command verb
get-command -noun smbmapping

# functions 
# get-smbmapping, 
# new-smbmapping, 
# remove-smbmapping



