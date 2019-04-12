Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

Import-Module posh-git
Import-Module pure-pwsh

New-Alias dc docker-compose
New-Alias la Get-ChildItem
New-Alias which Get-Command
