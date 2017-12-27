export NVM_AUTO_USE=true

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

# Load default node
if test $(command -v nvm)
then
  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ "$(nvm version default)" = "N/A" ]; then
      echo "Installing latest Long Term Support version of node as new default"
      nvm install lts/*
      nvm alias default lts/*
      # NPM checksums will fail due to a permissions issue
      # NPM will suggest this one-liner to make that issue go away
      # sudo chown -R $USER:$(id -gn $USER) /Users/ryanblakeley/.config
    fi

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi
