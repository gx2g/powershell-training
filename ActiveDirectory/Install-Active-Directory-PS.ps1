
# Install AD Domain Services with WhatIf to see if available, what would happen
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools -WhatIf

#If shows successful run excecution 
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
# <<Windows Powershell cmdlet and arguments>>

#
# Windows PowerShell script for AD DS Deployment
#


# Install ADDS Forest
Import-Module ADDSDeployment 

Install-ADDSForest '
-CreateDnsDelegation:$false '
-DatabasePath "C:\WINDOWS\NTDS" '
-DomainMode "WinThreshold" '
-DomainName "nuggetlab.com" '
-DomainNetbiosName "NUGGETLAB" '
-ForestMode "WinThreshold" '
-InstallDns:$true '
-LogPath "C:\WINDOWS\NTDS" '
-NoRebootOnCompletion:$false '
-SysvolPath "C:\WINDOWS\SYSVOL" '
-Force:$true'


# Install ADDS Domain Controller
Import-Module ADDSDeployment 

Install-ADDSDomainController '
-NoGlobalCatalog:$false '
-CreateDnsDelegation:$false '
-Credential (Get-Credentail) '
-CriticalReplicationOnly:$false '
-DatabasePath "C:\windows\NTDS" '
-DomainName "nuggetlab.com" '
-InstallDns:$true '
-LogPath "C:\Windows\NTSD" '
-NoRebootOnCompletion:$false '
-ReplicationSourceDC "DC01-22.nuggetlab.com" '
-SiteName "Default-First-Site-Name" '
-SysvolPath "C:\Windows\SYSVOL" '
-Force:$true'