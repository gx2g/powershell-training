# Checking Identiity of a Calendar based on email address
Get-MailboxCalendarFolder -Identity user@domain.com:\calendar

Get-MailboxCalendarFolder -Identity user@domain.com:\calendar

# Add permissions to calendar for user setting access rights to author
Add-MailboxFolderPermission -Identity mailbox@domain.com:\calendar -user user@domain.com -AccessRights Author

# set permissions to calendar for user setting access rights to author only works if value is not null
Set-MailboxFolderPermission -Identity mailbox@domain.com:\calendar -User user@domain.com -AccessRights Author

Remove-MailboxFolderPermission -Identity user1@domain.com:\calendar -User user2@domain.com


# EXOMail check if permission is applied
Get-EXOMailboxFolderPermission outofoffice:\calendar
