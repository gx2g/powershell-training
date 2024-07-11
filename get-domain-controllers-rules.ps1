(Get-ADForest).Domains | %{ Get-ADDomainController -Filter * -Server $_ } | fl Hostname,IsGlobalCatalog,OperatingSystem,OperationMasterRoles
