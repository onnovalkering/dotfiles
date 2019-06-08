# Dotfiles

### Install packages
```shell
cd .packages

brew bundle --file=Brewfile
npm install -g $(cat Npmfile)
while read e; do code --install-extension $e; done < code
```