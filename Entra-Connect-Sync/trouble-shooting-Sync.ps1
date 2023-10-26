# https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/tshoot-connect-password-hash-synchronization#no-passwords-are-synchronized-troubleshoot-by-using-the-troubleshooting-task

Import-Module ADSyncDiagnostics
Invoke-ADSyncDiagnostics -PasswordSync
Get-ADSyncConnector | Select Type, Name