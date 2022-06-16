# -WhatIf parameter after cmdlets, this only works for cmdlets thatchange system state such as Set-Service

# There is no -WhatIf parameter for cmdlets like Get-Process that display only information

# Run notepad once running type in powershell
Get-Process note* # using shorthand search
Stop-Process -id 10712 -WhatIf

# displays - What if: Performing the operation "Stop-Process" on target "notepad (10712)"

# You can also use -Confirm

Stop-Process -id 10712 -Confirm

# s to suspend execution when using -Confirm parameter

# Use Get-Process cmdlet to get a list of all running processes that start with letter n*
Get-Process n*