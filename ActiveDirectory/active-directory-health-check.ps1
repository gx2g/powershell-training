# Check to see if all services are running for Active Directory (services.msc) or powershell command
$Services='DNS','DFS Replication','Intersite Messaging','Kerberos Key Distribution Center','NetLogon','Active Directory Domain Services'
ForEach ($Service in $Services) {Get-Service $Service | Select-Object Name, Status}

<# 
Executing DCDiag for DNS will enable IT administrators to 
check the health of DNS forwarders, DNS delegation, and DNS record registration.
#>

# DCDiag /Test:DNS /e /v


<#

Detect unsecure LDAP binds.
The first step towards mitigating the vulnerability of unsecure LDAP binds is to identify 
whether you are affected, which you can do by looking through event ID 2887. 
Event 2887 is logged by default in the DC once every 24 hours, and it shows the number of 
unsigned and cleartext binds to the DC. Any number greater than zero indicates your DC is 
allowing unsecure LDAP binds.

Next, you need to detect all devices and applications using unsecure binds by looking through 
event ID 2889. Event 2889 is logged in the DC each time a client computer attempts an unsigned LDAP bind. 
It displays the IP address and account name of the computer that attempted to authenticate over 
an unsigned LDAP bind.

#>


# Check unsecure network binds
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
        ID = 2889
}