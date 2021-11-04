# Get Mailbox Info on curtain user.
Get-Mailbox -Identity user@company.com

# shows the Retention Policies you can select from
Get-RetentionPolicy

# Review a curtain Retention Policy for more Details
Get-RetentionPolicy -Identity "Retention Policy Name Here" | Format-List

