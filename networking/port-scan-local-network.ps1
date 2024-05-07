# common ports to choose from 
# https://tcp-udp-ports.com/win-ports.php

$port = (443)
$network = “192.168.1” # just the first 3
$range = 1..50 # host ranges to check
=======
# Specify the $port value to scan:
$port = 443

# Specify the $network value to scan, just the first 3:
$network = “192.168.1” 
# host ranges to check
$range = 1..50

# Enable silent scan (without error reporting) of said network: 

$ErrorActionPreference= "silentlycontinue"

# Calling the IP addresses one by one from the desired range and displaying the percentage to complete:
$(Foreach ($add in $range)
{ 

$ip = “{0}.{1}” -F $network,$add
Write-Progress “Scanning Network” $ip -PercentComplete (($add/$range.Count)*100)
    
    # Pinging the desired IP via the Test-Connection cmdlet to validate its existence on the network: 
    If (Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip)
    { 
        # Pinging the desired IP via the Test-Connection cmdlet to validate its existence on the network: 
        $socket = new-object System.Net.Sockets.TcpClient($ip, $port)
        # Report success if the desired port is open:
        If($socket.Connected) 
        { 
            “$ip port $port open”
            $socket.Close() 
        }
        else 
        { 
        “$ip port $port not open ” 
        }
    }

=======
#Create the CSV output file reporting on desired open port:
}) | Out-File D:\reports\portscan1.csv