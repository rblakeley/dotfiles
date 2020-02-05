# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gpull='git pull --prune'
alias glog='git log'
# alias othergitlog = '"git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit -m' # requires you to type a commit message
alias gco='git checkout'
# alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
# alias ga='git add .'
alias gac='git add -A && git commit -m'
alias ge='git-edit-new'
# alias gp='git push'
alias grm='git rm $(git ls-files --deleted)'

# checkout before certain date='git checkout `git rev-list -n 1 --before="2018-01-01 12:00" master`'
gcodate() { git checkout `git rev-list -n 1 --before="$1" master` }
