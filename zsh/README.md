Set up zsh externally

```bash
brew install zsh
sudo sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
chsh -s $(which zsh)
```
