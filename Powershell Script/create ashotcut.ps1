#
# create_ashotcut.ps1
#

# Create a Shortcut with Windows PowerShell
$TargetFile = "$env:SystemRoot\System32\notepad.exe"
$ShortcutFile = "$env:c:\ps\notepad.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()