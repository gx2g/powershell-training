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

get-distributiongroup -identity <nameofgroup> | Format-List


