# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Color LS
colorflag="-G"
alias ls="command ls ${colorflag}"
alias l="ls -1 ${colorflag}" # all files, in short format
alias ll="ls -lF ${colorflag}" # all files, in long format
alias la="ls -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='ls -lF ${colorflag} | grep "^d"' # only directories

# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
alias ca='pygmentize -O style=monokai -f console256 -g'

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Pasteboard copy without trailing newline
alias copy="tr -d '\n' | pbcopy"

# Generate a UUID and pipe to my clipboard.
alias uuid="uuidgen | tr -d '\n' | pbcopy | echo '=> Generated UUID copied to pasteboard.'"
