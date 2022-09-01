# Display User Mailbox Calendar Permissions for other Calendar Names applied to user. 
Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails SharedMailbox | Where-Object { Get-MailboxFolderPermission "$($_.PrimarySmtpAddress):\Calendar" -User kshaw -ErrorAction SilentlyContinue }