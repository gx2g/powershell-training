# Path for the public phonebook. Used as this is an all users connection.
# Change $env:PROGRAMDATA to $env:APPDATA if not creating an AllUserConnection.
$PbkPath = Join-Path $env:PROGRAMDATA 'Microsoft\Network\Connections\Pbk\rasphone.Pbk'

# Update these variables with the actual VPN name, address, and PSK.

# VPN Name
$ConnectionName = ''
# meraki host name example.dynamic-m.com
$ServerAddress = ''
# pre-share key
$PresharedKey = ''
# example: 192.168.0.0/24
$Destination = ''

# If no VPNs, rasphone.Pbk may not already exist
# If file does not exist, then create an empty placeholder.
# Placeholder will be overwritten when new VPN is created.
# Change $env:PROGRAMDATA to $env:APPDATA if not creating an AllUserConnection.
If ((Test-Path $PbkPath) -eq $false) {
    $PbkFolder = Join-Path $env:PROGRAMDATA "Microsoft\Network\Connections\pbk\"
    # Check if pbk folder actually exists. If it does, create place-holder phonebook.
    if ((Test-Path $PbkFolder) -eq $true){
        New-Item -path $PbkFolder -name "rasphone.pbk" -ItemType "file" | Out-Null
    }
    # If pbk folder doesn't exist, make folder then make place-holder phonebook.
    else{
        $ConnectionFolder = Join-Path $env:PROGRAMDATA "Microsoft\Network\Connections\"
        New-Item -path $ConnectionFolder -name "pbk" -ItemType "directory" | Out-Null
        New-Item -path $PbkFolder -name "rasphone.pbk" -ItemType "file" | Out-Null
    }
}

# If VPN exists, delete VPN connection
Remove-VpnConnection -AllUserConnection -Name $ConnectionName -Force -EA SilentlyContinue

# Adds the new VPN connection.
Add-VpnConnection -Name $ConnectionName -ServerAddress $ServerAddress -AllUserConnection -TunnelType L2tp -L2tpPsk $PresharedKey -AuthenticationMethod Pap -EncryptionLevel Optional -Force -WA SilentlyContinue

# Sets the VPN connection to split tunnel
# Comment out for full tunnel
Start-Sleep -m 100
Set-VpnConnection -Name $ConnectionName -SplitTunneling $True -AllUserConnection -WA SilentlyContinue

# If you need parameters to add metrics or for IPv6 subnets, open Powershell and run: get-help add-vpnconnectionroute -full
# This will give the full list of valid parameters for Add-Vpnconnectionroute and instructions for using them

# Adds the route for the interesting subnet
# $Destination should equal the interesting subnet with CIDR mask
# Comment out for full tunnel
Start-Sleep -m 100
Add-Vpnconnectionroute -Connectionname $ConnectionName -AllUserConnection -DestinationPrefix $Destination

# If there is more than one subnet for the client VPN on the destination network
# then we need an additional route for each subnet.
#
# Create an additional Destination# variable for each subnet
# Repeat the start-sleep and Add-Vpnconnectionroute lines once for each subnet.
# Update variable after -DestinationPrefix to match your new variable.
#
# You could make a loop for adding routes. My typical use case only has 1-2
# subnets though so...
#
# Remove # from lines below to use the code.
#
# $Destination15 = '192.168.15.0/24'
# Start-Sleep -m 100
# Add-Vpnconnectionroute -Connectionname $ConnectionName -AllUserConnection -DestinationPrefix $Destination15

# Set RASPhone.pbk so that the Windows credential is used to authenticate to servers.
# Important when you use Meraki cloud credentials.
(Get-Content -path $PbkPath -Raw) -Replace 'UseRasCredentials=1','UseRasCredentials=0' | Set-Content -pat $PbkPath

# Create desktop shortcut for all users using rasphone.exe
# Provides a static box for end users to type user name/password into
# Avoids Windows 10 overlay problems such as showing "Connecting..." even
# after a successful connection.
$ShortcutFile = "$env:Public\Desktop\$ConnectionName.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = "rasphone.exe"
$Shortcut.Arguments = "-d `"$ConnectionName`""
$ShortCut.WorkingDirectory = "$env:SystemRoot\System32\"
$Shortcut.Save()

# Prevent Windows 10 problem with NAT-Traversal (often on hotspots)
# See https://documentation.meraki.com/MX/Client_VPN/Troubleshooting_Client_VPN#Windows_Error_809
# for more details
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\PolicyAgent"
$Name = "AssumeUDPEncapsulationContextOnSendRule"
$value = "2"
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
{
# By Tom Chantler - https://tomssl.com/2019/04/30/a-better-way-to-add-and-remove-windows-hosts-file-entries/

# machine ip example 192.168.0.333
# hostname of the machine
param([string]$DesiredIP = ""
    ,[string]$Hostname = " "
	,[bool]$CheckHostnameOnly = $false
    , [string]$DesiredIP2 = ""
    ,[string]$Hostname2 = "")

    # Adds entry to the hosts file.
    # Requires -RunAsAdministrator

$hostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"
$hostsFile = Get-Content $hostsFilePath

Write-Host "About to add $desiredIP for $Hostname to hosts file" -ForegroundColor Gray
Write-Host "About to add $desiredIP2 for $Hostname2 to hosts file" -ForegroundColor Gray

$escapedHostname = [Regex]::Escape($Hostname)
$escapedHostname2 = [Regex]::Escape($Hostname2)
$patternToMatch = If ($CheckHostnameOnly) { ".*\s+$escapedHostname.*" } Else { ".*$DesiredIP\s+$escapedHostname.*" }
$patternToMatch2 = If ($CheckHostnameOnly) { ".*\s+$escapedHostname2.*" } Else { ".*$DesiredIP2\s+$escapedHostname2.*" }
If (($hostsFile) -match $patternToMatch)  {
    Write-Host $desiredIP.PadRight(20," ") "$Hostname - not adding; already in hosts file" -ForegroundColor DarkYellow
} 
Else {
    Write-Host $desiredIP.PadRight(20," ") "$Hostname - adding to hosts file... " -ForegroundColor Yellow -NoNewline
    Add-Content -Encoding UTF8  $hostsFilePath ("$DesiredIP".PadRight(20, " ") + "$Hostname")
    Write-Host " done"
}
If (($hostsFile) -match $patternToMatch2)  {
    Write-Host $desiredIP2.PadRight(20," ") "$Hostname2 - not adding; already in hosts file" -ForegroundColor DarkYellow
} 
Else {
    Write-Host $desiredIP2.PadRight(20," ") "$Hostname2 - adding to hosts file... " -ForegroundColor Yellow -NoNewline
    Add-Content -Encoding UTF8  $hostsFilePath ("$DesiredIP2".PadRight(20, " ") + "$Hostname2")
    Write-Host " done"
}
}