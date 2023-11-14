# The get-windowsfeature PowerShell command will get information 
# about installed and available features and roles.

Get-WindowsFeature

# You probably just want a list of installed roles and features, this can be done with the following command:

Get-WindowsFeature | Where-Object {$_.installstate -eq "installed"}

# The display name and name are basically the same so I’m going to remove the Display name column.

Get-WindowsFeature | Where-Object {$_.installstate -eq "installed"} | Select-Object Name, installstate

# The command is exactly the same you just need to add -ComputerName PCNAME to the command.
Get-WindowsFeature -ComputerName dc1 | Where-Object {$_. installstate -eq "installed"} | Select-Object Name,Installstate

#  wildcard search for Active Directory roles
Get-WindowsFeature *ad*

