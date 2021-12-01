
# Example: is .Net Core 3.1 Runtime installed?
$software = "Microsoft .NET Core Runtime - 3.1.0 (x64)";
$installed = $null -ne (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq $software })

If(-Not $installed) {
	Write-Host "'$software' NOT is installed.";
} else {
	Write-Host "'$software' is installed."
}

# Smaller way of doing it 
(Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Contains "Microsoft .NET Core Runtime - 3.1.0 (x64)"

# Need to check a partial name?
((Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "Core Runtime - 3.1").Length -gt 0

# Need to know the name of the software installed, use the same query to print the matching results. 
(Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*).DisplayName -Match "Core SDK"

