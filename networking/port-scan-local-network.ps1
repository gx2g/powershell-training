# common ports to choose from 
# https://tcp-udp-ports.com/win-ports.php

$port = (put port number here)
$network = “192.168.1” # just the first 3
$range = 1..50 # host ranges to check
$ErrorActionPreference= "silentlycontinue"

$(Foreach ($add in $range)
{ 
    $ip = “{0}.{1}” -F $network,$add
    Write-Progress “Scanning Network” $ip -PercentComplete (($add/$range.Count)*100)
    
    If (Test-Connection -BufferSize 32 -Count 1 -quiet -ComputerName $ip)
    { 
        $socket = new-object System.Net.Sockets.TcpClient($ip, $port)
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

}) | Out-File D:\reports\portscan1.csv