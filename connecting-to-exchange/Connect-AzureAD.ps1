# Connect to AzureAD to edit changes when in hybrid, on-prem situations. 

Install-Module -Name AzureAD

# If powershell older then .x and AzureAD is installed. Simply remove it and reinstall if needed. 

Uninstall-Module -Name AzureAD
Install-Module -Name AzureAD

# Then import the module 

Import-Module AzureAD

# Then connect to azureAD

Connect-AzureAD


# Saved Commands from some of my activity

get-distributiongroup

remove-distributiongroup "name of group"

# change name of group to group name you are looking to review detailed object properties. 
get-distributiongroup -identity nameofgroup | Format-List


# ================================================================================ #
# Azure AD Connect 2.0 tools

Import-Module AzureAD
Connect-AzureAD

# View DirSync Status, you must connect to Azure AD
Get-Module MSOnline
Get-Module MSolService

Get-MsolCompanyInformation



# ================================================================================ #