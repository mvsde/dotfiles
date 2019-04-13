# Disable the annoying bell
Set-PSReadlineOption -BellStyle None

# Quit terminal with Ctrl+D
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

# Enhance the history
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Bash-style tab completions
Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Aliases
New-Alias dc docker-compose
New-Alias la Get-ChildItem
New-Alias which Get-Command

# Modules
Import-Module PSReadLine
Import-Module posh-git
Import-Module pure-pwsh
