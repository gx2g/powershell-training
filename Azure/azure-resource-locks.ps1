# LINK - https://www.youtube.com/watch?v=6XVF0u9JCro

# CanNotDelete - means authorized users can still read and modify a resource, 
# but they can't delete the resource.

# ReadOnly - means authorized users can read a resource, but they can't delete or update the resource.
# Applying this lock is similar to restricking all authorized users to the permissions granted by 
# the Reader Role.

New-AzResourceLock -LockName LockGroup -LockLevel CanNotDelete -ResourceGroupName exampleresourcegroup
az lock create --name LockSite --lock-type CanNotDelete --resource-group exampleresourcegroup --resource-name examplesite --resource-type Microsoft.Web/sites