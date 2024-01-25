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