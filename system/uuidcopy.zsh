# Generate a UUID and pipe to my clipboard.
alias uuid="uuidgen | tr -d '\n' | pbcopy | echo '=> Generated UUID copied to pasteboard.'"
