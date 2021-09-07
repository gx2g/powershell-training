# PowerShell itself comes with several built-in modules, including 
# PowerShellGet, ThreadJob, PSReadLine, and the commands in the Microsoft.PowerShell.* modules.
Get-Module

Get-Module Microsoft.PowerShell.*

# The ListAvailable parameter shows the list of modules that are available on 
# the system instead of just those that have been imported:
Get-Module -ListAvailable
