<#

Install-Module Microsoft.Graph -Force
Install-Module Microsoft.Graph.Beta -AllowClobber -Force
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All", "Directory.AccessAsUser.All"

#>


# Define the path to the CSV file
$csvFilePath = "C:\temp\examplefile.csv"

# Load the CSV data into a variable
$csvData = Import-Csv -Path $csvFilePath

# Define the new password
$newPassword = "AddPasswordHere"

# Define force password change after sign in
$ForceChangePasswordNextSignIn = "true" #or "false"

# Loop through each user in the CSV data and update their password
foreach ($user in $csvData) {
    $userPrincipalName = $user.UserPrincipalName

    # Check if the user exists
    $existingUser = Get-MgUser -UserId $userPrincipalName -ErrorAction SilentlyContinue

    if ($existingUser -ne $null) {
        try {
            Update-MgUser -UserId $userPrincipalName `
                -PasswordProfile @{
                password                      = $newPassword;
                ForceChangePasswordNextSignIn = $ForceChangePasswordNextSignIn
            } -ErrorAction Stop

            Write-Host "Password updated for user: $userPrincipalName" -ForegroundColor Green
        }
        catch {
            Write-Host "Failed to update password for user: $userPrincipalName" $_.Exception.Message -ForegroundColor Red
        }
    }
    else {
        Write-Host "User not found: $userPrincipalName" -ForegroundColor Yellow
    }
}