
# Add permissions to calendar for user setting access rights to author
Add-MailboxFolderPermission -Identity mailbox@domain.com:\calendar -user user@domain.com -AccessRights Author

# EXOMail check if permission is applied
Get-EXOMailboxFolder:Permission outofoffice:\calendar