


get-aduser -filter * -properties Name, PasswordNeverExpires | where {$_.passwordNeverExpires -eq "true" } | select SamAccountName, PasswordNeverExpires, DistinguishedName, Enabled | Export-CSV “C:\\password-never-expires1.csv” -NoTypeInformation -Encoding UTF8