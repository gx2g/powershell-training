# Get Mailbox Info on curtain user.
Get-Mailbox -Identity user@company.com

# shows the Retention Policies you can select from
Get-RetentionPolicy

# Review a curtain Retention Policy for more Details
Get-RetentionPolicy -Identity "Retention Policy Name Here" | Format-List

<# 
Check if there is a litigation hold on the account effecting the account from being disabled
On-Premise accounts disabled user but in 365 email account has object error. 

Exchange: The execution of cmdlet Disable-Mailbox failed..; 
Exchange: An unknown error has occurred. Refer to correlation ID:
#>

Get-Mailbox user@company.com | Format-List LitigationHoldEnabled,InPlaceHolds

## 
get-recipient -Identity user@company.com | format-list