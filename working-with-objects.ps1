# PowerShell has a variety of commands that work 
# with arrays (or collections) of objects in a pipeline.

# In this chapter we'll focus on
# Pipelines
# Members
# Enumerating and Filtering
# Selecting and Sorting
# Grouping and Measuring
# Comparing
# Importing, Exporting, and Converting

# In PowerShell, the streams are 
# Standard, Error, Warning, Verbose, Debug, and Information.

# We can see an example of this by looking at the outputs of these next commands. 

# Here we simply use the command on it's own. 
Get-CimInstance -ClassName Win32_ComputerSystem;

# Here we add the command to a variable and call the varaible to preview the output. 
$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem;

# Here we add -Verbose to the end and noticed more information is displayed when you call
# the variable. This information is not stored in the variable. 
$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem -Verbose;
$computerSystem;

##  stream           | Command            | Stream Number ##
##________________________________________________________##
##  Standard Output  | Write-Output       | 1             ##
##  Error            | Write-Error        | 2             ##     
##  Warning          | Write-Warning      | 3             ##
##  Verbose          | Write-Verbose      | 4             ##
##  Debug            | Write-Debug        | 5             ##
##  Information      | Write-Information  | 6             ##
##________________________________________________________##

# In Powershell 5v and later the Write-Host command became a wrapper for Write Information.


# The Pipeline | is used to send objects from one command to another. 

Get-Process | Where-Object WorkingSet64 -gt 50MB;
