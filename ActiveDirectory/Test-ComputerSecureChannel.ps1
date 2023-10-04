# Tests and repairs the secure channel between the local computer and its domain.

# This command tests the channel between the local computer and the domain to which it is joined.
Test-ComputerSecureChannel

# This command specifies a preferred domain controller for the test.
Test-ComputerSecureChannel -Server "serverName.domain.local"

# This command resets the channel between the local computer and its domain.
Test-ComputerSecureChannel -Repair

# This command uses the Verbose common parameter to request detailed messages about the operation. 
Test-ComputerSecureChannel -Verbose

# This example shows how to use Test-ComputerSecureChannel to test a connection before you run a script that requires the connection.
# The if statement checks the value that Test-ComputerSecureChannel returns before it runs a script.

if (!(Test-ComputerSecureChannel)) {
    Write-Host "Connection failed. Reconnect and retry."
}
else {
    &(.\Get-Servers.ps1)
}