#training website - https://www.youtube.com/watch?v=SmHpKgKashg

$PSVersionTable;

# Examples of Command lets

Get-Date;
New-Item;
Remove-Module;

# Three Important Cmdlets

Get-Command;   
 # Powershell's dictionary lookup, this will help you find cmdlets you can use.
Get-Help;       
# Powershell has help info baked right in, just like "man" pages in *nix. 
Get-Member;     
# Since Powershell is object aware, this cmdlet helps explore the Methods and Properties.

#Cmdlets - the core functionality 
#Get-Date, Verb-Noun
Get-Date;

# What if we wanted to see all the verbs?
Get-Verb;

# Get-Command, The Dictonary Lookup
Get-Command;
Get-Command -Name "New";

# Get-Help, describing a specific cmdlet
Get-Help Get-Command;
Get-Help Get-Command -Full;

