# finding commands
# using * * helps narrow down the search 

Get-Command Get-*Firewall*

# =============================================================

# Same as Dir or LS
Get-ChildItem;

# Alias GCI with path parameter displays directories with their LastWriteTime, Length (file size), Name 
gci -Path C:\Users\

# Alias GCI with path parameter and file parameter displays files only in directory
gci -Path c:\Users\rresendez\desktop\ -File 

# Alias GCI with path parameter and file parameter pipe Name property
gci -Path c:\Users\rresendez\desktop\ -File | Select Name

# Alias GCI with path parameter and file parameter pipe Select Length for File Size
gci -Path C:\Users\rresendez\Desktop\ -File | Select Length

# Alias GCI with path parameter and Recurse, Force and File parameter will get all files and sub files 
gci -Path C:\Users\rresendez\Desktop\ -Recurse -Force -File

# Alias GCI with path parameter and Recurse using Include parameter to find curtain types of files. 
gci -Path C:\Users\rresendez\Desktop\ -Recurse -Include *.zip, *.txt