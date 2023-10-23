Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version, Release -EA 0 | Where { $_.PSChildName -Match '^(?!S)\p{L}'} | Select PSChildName, Version, Release