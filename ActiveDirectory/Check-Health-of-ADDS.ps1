# Check if DC's are syn'd and that replication is on going
Repadmin /ReplSummary

# Make sure Dependancy Services are running. 
# In services.msc you will find these under Active Directory Domain Services

$Services='DNS','DFS Replication','Intersite Messaging','Kerberos Key Distribution Center','NetLogon',’Active Directory Domain Services’
ForEach ($Service in $Services) {Get-Service $Service | Select-Object Name, Status}