# Dotfiles

### Install packages
```shell
cd .packages

brew bundle --file=brew
npm install -g $(cat npm)
for e in `cat code`; do code --install-extension $e; done
```