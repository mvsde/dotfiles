# Disable the annoying bell
Set-PSReadlineOption -BellStyle None

# Quit terminal with Ctrl+D
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

# Enhance the history
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
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

# Touch
function touch {
  New-Item -ItemType File $args
}

# File hashes
function md5 {
  Get-FileHash -Algorithm MD5 $args
}

function sha1 {
  Get-FileHash -Algorithm SHA1 $args
}

function sha256 {
  Get-FileHash -Algorithm SHA256 $args
}
