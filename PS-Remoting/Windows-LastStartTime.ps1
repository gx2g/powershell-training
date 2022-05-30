
# LastStartTime for a system will be displayed from local computer. what if you want to do this from remote computer
Get-WmiObject Win32_OperatingSystem -ComputerName "computername" | Select-Object @{Name = 'LastStartTime' ; Expression = {[Management.ManagementDateTimeConverter]::ToDateTime($_.LastBootUpTime)}}

# Trying to get information from IP remote computer. 
Get-WmiObject Win32_OperatingSystem -ComputerName "IP Address"

# Ruen WinRM on both machines to confirm local access is setup. 
# winrm help config

# WinRM quick config will tell you want to do. 
# winrm quickconfig

# set the ip address to trust from each others IP
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "IP Address"
# Check on both machines that they are added to this TrustHosts for communication
Get-Item WSMan:\localhost\Client\TrustedHosts

# Use Test WSMan IP address to see if all is working
Test-WSMan "IP ADDRESS"

# Enter PSSession to remote computer and sign in. 
Enter-PSSession -ComputerName "IP ADDRESS" -Credential $Credentials 

# Works only after making sure PSRemoting is on with IP's both machines
# This is how you invoke a command on a remote machine. 
Invoke-Command -ComputerName "IP ADDRESS" -ScriptBlock { Get-WmiObject Win32_OperatingSystem -ComputerName "ComputerName" } -credential "ComputerUser"


# Created a function called Get-TSUptime to make it easier. 
Function Get-TSUptime {
    param ($ComputerName = $env:COMPUTERNAME)
    $WmiOS = Get-WmiObject Win32_OperatingSystem -ComputerName $ComputerName
    [Management.ManagementDateTimeConverter]::ToDateTime($WmiOS.LastBootUpTime)
}


Function Get-TSFreeSpace {
    [CmdletBinding()]
    param ($ComputerName = $env:COMPUTERNAME)
    $allDisks = Get-WmiObject -ComputerName $ComputerName -Class Win32_LogicalDisk -Filter "DriveType='3'"
    foreach ($disk in $allDisks){
        $results += [PSCustomObject]@{
            'ComputerName' = $disk.DeviceID
            'FreeSpace(GB)' =$([int]($disk.FreeSpace / 1GB))
            'Size(GB)' = $([int]($disk.size / 1GB))
        }
    }
    $results
}