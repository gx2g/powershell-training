# If the response has values for all four values, 
# especially CurrentUserCurrentHost, you have a profile.

$profile | Get-Member -Type NoteProperty

# If you don't have one you can create one with,

if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
  }