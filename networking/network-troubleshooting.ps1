# Network trouble shooting using powershell

# ping becomes Test-Connection
Test-Connection 192.168.1.1

# ping -t becomes Test-Connection <IP> -Continues
Test-Connection 192.168.1.1 -Continuous


# NSLookup becomes Resolve-DnsName <IP>
Resolve-DnsName 192.168.1.1


######################################
# Local Configuration
######################################


# IPConfig becomes Get-NetIPConfiguration
Get-NetIPConfiguration

#ipconfig /all
Get-NetIPConfiguration -Detailed

# ipconfig /release
N/A

# ipconfig /renew
N/A

# netstat
Get-NetTCPConnection

######################################
# Remote Connectivity
######################################

# ping 8.8.8.8
Test-NetConnection 8.8.8.8

# ping -t
while($true){Test-Connection 8.8.8.8}

# tracert 8.8.8.8
Test-NetConnection 8.8.8.8 -TraceRoute

# telnet 8.8.8.8 25
Test-NetConnection -Port 25

######################################
# DNS
######################################

# nslookup 
Resolve-DnsName

# ipconfig /flushdns
Clear-DnsClientCache

# ipconfig /registerdns 
Register-DnsClient

# ipconfig /displaydns
Get-DnsClientCache


######################################
# Test Network Connection swiss army combines many functions
######################################

Test-NetConnection -ComputerName 192.168.1.1

Test-NetConnection -ComputerName 192.168.1.1 -TraceRoute

# control + spacebar to open up atributes such as "-" then holding down ctrl + space

# Test computer IP if listening on port 443
Test-NetConnection -ComputerName 192.168.1.1 -Port 443

# Find NameResolutionResults 
Test-NetConnection -ComputerName 192.168.1.1 -InformationLevel Detailed

# combine when opting for detail info example on a port listening
Test-NetConnection -ComputerName 192.168.1.1 -InformationLevel Detailed -Port 443

 
$Computers = @(
    "192.168.1.1"
    "192.168.1.2"
    "192.168.1.3"
    "192.168.1.4"
)

foreach ($comp in $computers){
    if(Test-Connection -ComputerName $comp -Count 1 -Quiet){
        $comp
    }
}