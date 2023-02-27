# Open Session in Azure Cloud Shell in Azure Powershell

# Create resources groups
# Create managed disks
# Change the configuration of the managed disks


# Use an existing resource group and create an Azure managed disk by using Azure PowerShell

# run commands to retrieve the properties of the resource group
# change az104-03b-rg1-681427 to the name of resource group you are using. 

$location = (Get-AzResourceGroup -Name az104-03b-rg1-681427).location

$rgName = 'az104-03b-rg1-681427'

Get-AZ-AZResourceGroup = -Name $rgName

# Create a Managed Disk with the properties
$diskConfig = New-AzDiskConfig '
-Location $location '
-CreateOption Empty '
-DiskSizeGB 32 '
-Sku Standard_LRS

$diskName = 'az104-03c-disk1'
New-AzDisk '
-ResourceGroupName $rgName '
-DiskName $diskName '
-Disk $diskConfig '

# Retrieve the properties of the newly created disk. 
Get-AzDisk -RecourseGroupName $rgName -Name $diskName

# Configure the managed disk by using Azure PowerShell

# Increase the size of the Azure managed disk to 64 gigs
New-AzDiskUpdateConfig -DiskSizeGB 64 | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName

# Verify that the change took effect

Get-AzDisk -ResourceGroupName $rgName -Name $diskName

# Verify the curernt SKU as standard LRS
(Get-AzDisk -ResourceGroupName $rgName -Name $diskName).Sku

# Change the disk performace sku to premium LRS
New-AzDiskUpdateConfig -Sku Premium_LRS | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName

# Verify that the change took effect
(Get-AzDisk -ResourceGroupName $rgName -Name $diskName).Sku





