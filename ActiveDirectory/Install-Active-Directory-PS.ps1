Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
# <<Windows Powershell cmdlet and arguments>>

#
# Windows PowerShell script for AD DS Deployment
#

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
-Force:$true