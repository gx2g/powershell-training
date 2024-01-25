# https://blog.netwrix.com/2023/05/15/active-directory-domain-controller-for-the-domains-couldnot-be-contacted

# An Active Directory DOmain Controller - Could Not Be Contacted

# In most cases, the issue is related to one of the following: incorrect 
# DNS settings or a wrong IP address on your system, DNS misconfiguration 
# on the domain controller (DC) side, or ports that are blocked on the firewall.

Get-Service dnscache

# Check host file for domain or domain controller entries

get-content C:\Windows\System32\Drivers\etc\hosts

# Restart the DNS Cache Service
ipconfig /flushdns

# Then stop and restart the dnscache service

net stop dnscache && net start dnscache

# Alternatively, you can use the Service.msc console. Right-click on DNS Client to open its properties dialog:

# Check whether the DC is Reachable from the Client

ping your-domain-name.com

# Run a tracecert

tracert domain-controller
<#
You should also check the availability of the DC from another workstation on the same network. 
If your client cannot access the DC but other clients can, there could be a problem with your 
client’s cable or hardware, or with a device in the middle. To narrow down the problem, try a 
different network jack or go wireless.
#>

# Check the DC’s Accessibility using PowerShell

# Display IP Address
Get-NetIPConfiguration -All

# Ping the DC
Test-NetConnection your-domain-name.com

# Trace the routes to the DC
Test-NetConnection -TraceRoute your-domain-name.com

# GUI way 

<#
Add the DNS server to the TCP/IP settings of your Network Adapter

If the domain controller can be reached, try adding the IP address of your DNS server to your network adapter’s Advanced TCP/IP settings.

1.) Open Control Panel, click Network and Sharing Center, and then click Change adapter settings:
2.) Right-click on the network adapter and select Properties.
3.) Right-click on Internet Protocol Version 4 (TCP/IPv4) and choose Properties.
4.) Click the Advanced button and go to the DNS tab.
5.) On the DNS tab, click the Add button, provide the IP address of your DNS server and click OK. 
    (Note that the DNS server might be a DC, especially if it’s a small organization.)
6.) If multiple IP addresses are listed, use the arrow buttons to move your preferred one to the top of the list. Then click OK.
7.) Click OK again to save your changes.
8.) Restart the workstation or server so the changes will take effect, and try again to join the workstation or server to the Active Directory domain.

#>

<#
Check whether you’re using the Right DNS servers

Before you go too deep down the rabbit hole, double-check that you are using the correct DNS servers. Specifically, 
the DNS servers that DCs are aware of are used to register records that help AD-connected devices locate resources like DCs; 
DNS servers that are not AD-integrated do not have these records.

According, make sure you are using one of the following:

- A DNS server with Active Directory integration
- A DNS server that replicates records from another DNS server that is aware of Active Directory
- A DNS server configured to query either an AD-integrated DNS server or a DNS server with duplicated records via forwarding

    To check that your DNS server is one of these, use the PowerShell cmdlet shown below in a PowerShell session on a domain-joined PC. 
    (If you don’t have another domain client to use, you will need to contact your network staff.)

#>

Get-DnsClientServerAddress
# (Note) DNS Servers used by the client computer are in the Server Address column. 

# If you need to update the settings 
Set-DnsClientServerAddress

# Set the DNS server addresses on an interface with a specified index value:
Set-DnsClientServerAddress -InterfaceIndex 12 -ServerAddresses ("10.0.0.1","10.0.0.2")
# (Note) the 12 is the ifIndex ID for the interface, check to get the correct one

# Reset a DNS client to use the default DNS server addresses:
Set-DnsClientServerAddress -InterfaceIndex 12 -ResetServerAddresses

# This example resets the DNS client to use the default DNS server addresses specified by DHCP 
# on the interface with an index value of 12.

