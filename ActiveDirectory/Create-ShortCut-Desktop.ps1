# Create ShortCut Icon on Desktop

TargetFile = "\<folderpath>\"
$ShortcutFile = "$env:Public\Desktop\FolderNameHere.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()

