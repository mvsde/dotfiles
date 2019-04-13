# Disable the annoying bell
Set-PSReadlineOption -BellStyle None

# Quit terminal with Ctrl+D
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

# Use PSReadline for history
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Aliases
New-Alias dc docker-compose
New-Alias la Get-ChildItem
New-Alias which Get-Command

# Modules
Import-Module posh-git
Import-Module pure-pwsh
