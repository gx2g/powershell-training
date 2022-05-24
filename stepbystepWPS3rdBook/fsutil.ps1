
#Applies to Windows Server 2012 & R2, 2019, 2016, Win 10, Win 8.1, Windows Server 2008 R2, Win 7
#fsutil file, Finds a file by user name (if Disk Quotas are enabled), queries allocated ranges for a file, 
#sets a file's short name, sets a file's valid data length, sets zero data for a file, or creates a new file.
#Examples - Note < > is placeholder must be changed 
#To find files that are owned by scottb on drive C, type:

fsutil file findbysid <username> c:\users

#creating a dummy file that is 1k kilobytes, you can increase the file size  

fsutil file createnew c:\users\<username>\desktop\test\myfile.txt 1000



# Displaying some drive properties

# obtain drive lists for a computer
fsutil fsinfo drives

# obtain drive type
fsutil fsinfo drive type d:


# Obtaining some general volume information
fsutil fsinfo volumeinfo c:

# Determining amount of free space on a drive
fsutil volume diskfree c:
