#############################################################

    # Get-ADDomain
    # Get-ADTrust -Filter *
    # Get-ADForest | Select Name, ForestMode
    # Get-ADDomain | Select Name, DomainMode

#############################################################

# Forest Wide Roles: 
    # Schema Master
    # Domain naming master

# Domain Wide Roles: 
    # PDC
    # RID pool manager
    # Infrastructure master

# Method 1: Run cmd and type (netdom query fsmo) 

# Method 2: Powershell

# Returns Forest FSMO Rules
Get-ADForest domain.local | Format-Table SchemaMaster, DomainNamingMaster;

# Returns Domain FSMO Roles
Get-ADDomain domain.local | Format-Table PDCEMulator, RIdMaster, InfrastructureMaster;

# Why Transfer FSMO Roles?

# By Default all five FSMO roles are assigned to the first domain controller in the forest root domain. Transfering roles is often needed for a few reasons. 
    # - Upgrading the operating system
    # - Changing IP addresses on a domain controller
    # - Demoting a domain controller
    # - Taking a domain controller offline for maintenance
    # - Performance issues


    ############################################################################
    # Check Source DSA and Destination DSA, times and check for failures
    Repadmin /replsummary
    
    # Check Replication Status between all the domain controllers
    # Looking for last attempt successful
    Repadmin /showrepl
    
    # Check the Queue to make sure nothing is in the queue
    Repadmin /queue
    
    # Moving all the roles at once
    # Move-ADDirectoryServerOperationMasterRole -Identity "DC01" -OperationMasterRole 0.1,2,3,4

    Move-ADDirectoryServerOperationMasterRole -Identity "DCO1" -OperationMasterRole
