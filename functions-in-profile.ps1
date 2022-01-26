# If the response has values for all four values, 
# especially CurrentUserCurrentHost, you have a profile.

$profile | Get-Member -Type NoteProperty

# If you don't have one you can create one with,

if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
  }


  # The profile paths include the following variables
  
  # The $PSHOME variable, which stores the installation directory for PowerShell
  $PSHOME;

  # The $Home variable, which stores the current user's home directory
  $HOME;

  # Visual Studio Code supports the following host-specific profiles

  # ALL USERS, Current Host - $PSHOME\Microsoft.VSCode_profile.ps1
  # CURRENT USER, Current Host - $Home\[My ]Documents\PowerShell\Microsoft.VSCode_profile.ps1

  # In PowerShell Help, the "CurrentUser, Current Host" profile is the profile 
  # most often referred to as "your PowerShell profile".