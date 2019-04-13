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

# Implement Unix-like rm -rf
Remove-Item 'Alias:\rm' -Force
function rm {
  $additional_args = $args[1..($args.Count-1)]

  switch ($args[0]) {
    "-r" {
      Remove-Item -Recurse $additional_args
    }
    "-f" {
      Remove-Item -Force $additional_args
    }
    "-rf" {
      Remove-Item -Recurse -Force $additional_args
    }
    default {
      Remove-Item $additional_args
    }
  }
}
