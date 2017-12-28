# Clone the zsh-nvm plugin (https://github.com/lukechilds/zsh-nvm#manually)
if ! [[ -a ~/.zsh-nvm ]]
then
  git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-nvm
fi

# Clone the better npm completion plugin (https://github.com/lukechilds/zsh-better-npm-completion)
if ! [[ -a ~/.zsh-better-npm-completion ]]
then
  git clone https://github.com/lukechilds/zsh-better-npm-completion.git ~/.zsh-better-npm-completion
fi

# Load the zsh-nvm plugin
if [[ -a ~/.zsh-nvm ]]
then
  source ~/.zsh-nvm/zsh-nvm.plugin.zsh
fi

# TODO: Load the better npm completion plugin
# - throws error about command compdef not existing
# if [[ -a ~/.zsh-better-npm-completion ]]
# then
  # source ~/.zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh
# fi
