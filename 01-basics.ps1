# get-help command to look for help
Get-Help

# update help command gets the latest packages supported
Update-Help

# You can view a list of modules that support updatable help by running the following command:
Get-Module -ListAvailable | Where-Object HelpInfoUri

# Used to force updates and silently continue on errors
Update-Help -Verbose -Force -ErrorAction SilentlyContinue

# show all commands available
Get-Command -All

# wild card, grab everything with that name
Get-Command *process*

####################################################
Get-ChildItem | sort-object -Descending -Property lastwritetime
Get-ChildItem | foreach { "$($_.GetType().fullname) - $_.name"}
####################################################