#### Learning 
#### https://devblogs.microsoft.com/scripting/use-windows-powershell-to-search-for-files/

# Returns the C:\ directory folders, files
Get-Childitem -Path C:\

# -Recurse returns / shows everything we have access too, showing sub folders
Get-Childitem -Path c:\ -Recurse

# Files you can't access through an error making it hard to read so we use the -ErrorAction SilentlyContinue to not be bothered with them. 
Get-Childitem -Path c:\ -Recurse -ErrorAction SilentlyContinue


# searching we use -include (only show me these files) and -exclude (don't show me these files)
# we use the -force command to find files in temp folders such as Temporary Outlook folder that are hidden. 
Get-Childitem -Path c:\ -Recurse -Force -ErrorAction SilentlyContinue

# -include command without file shows all types of folders and files
Get-Childitem -Path C:\ -Include *test* -Recurse -ErrorAction SilentlyContinue

# -include command with file shows only file types with match
Get-Childitem -Path c:\ -include *test.txt* -File -Recurse -ErrorAction SilentlyContinue


# -exclude works like this
Get-Childitem -Path c:\ -Include *test* -Exclude *.jpg, *.mp3, *.tmp -File -Recurse -ErrorAction SilentlyContinue



# Great way to find documents and list them for all files 
Get-ChildItem -Path C:\users\<username>\desktop\ -Include *.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue


# Lets set a time so variable so we can use two commands together / pipe which will include all files since that day
$FindDate = Get-Date -Year 2021 -Month 01 -Day 01

# Combine the two together like this using Where Object LastWriteTime greater then $FindDate
Get-ChildItem -Path c:\users\<username>\desktop\ -include *.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue | Where-Object {$_.LastWriteTime -ge $FindDate}

Get-ChildItem -Path c:\users\<username>\desktop\ -include *.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue | Where-Object {$_.LastWriteTime -ge $FindDate -AND $_.LastWriteTime -le $Finddate.adddays(1)}