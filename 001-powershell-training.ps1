# Powershell Training

$psversiontable; 

Get-Command -noun CimSession
Get-Command -noun CimInstance

#only difference is the Invoke-Command

Get-WmiObject win32_operatingsystem | Format-List
# deprecated 

Get-CimInstance win32_operatingsystem | Format-List

<#
WMI and CIM are nearly identical except for minor cosmetic differences in the output. 
However, accessing from a remote pc is different between the two at the network level. 
For a WMI connection to succeed, the remote computer must permit incoming network traffic 
on TCP ports 135, 445, and additional dynamically assigned ports between 1024 to 1034. 
The dynamic range of ports and the number of ports needed to make a successful connection
make security pros nervous about using WMI on a corporate network.

In 2012, Microsoft addressed these concerns by releasing a new version of WMI called Windows 
Remote Management (WinRM) or more commonly called PSRemoting. 
It uses the Web Services for Management protocol (WS-Man) for data transfer between 
computers instead of DCOM and needs only two ports to make a secure connection.

From a security perspective, the default configuration for PSRemoting is secure by default. 
Windows Remote Management (WinRM) is the service on a Windows computer that creates and maintains 
the connection to another computer on a Windows network. WinRM uses the WSMan protocol to transfer 
data between computers securely. The WSMan protocol uses ports 5985 and 5986 and those ports connect 
via HTTP and HTTPS. All traffic is encrypted by default even when using an insecure protocol 
like HTTP. Also, PSRemoting leverages Active Directory for authentication. By default, PSRemoting 
uses Kerberos to authenticate users and determine what level of access they should have on the 
remote computer. WMI has similar controls you can put in place, but they are much harder to 
configure and are not secure by default.


https://www.ipswitch.com/blog/get-ciminstance-vs-get-wmiobject-whats-the-difference
https://www.pdq.com/blog/powershell-guide-get-ciminstance-and-get-wmiobject/

#>