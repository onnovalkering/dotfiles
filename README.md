# Dotfiles
This is the configuration I use for macOS and Ubuntu.

```shell
cd $HOME
git init
git remote add origin git@github.com:onnovalkering/dotfiles.git
git fetch
git checkout --force master
```

## Notes to self

Passwordless sudo:
```
%onno	ALL=(ALL) NOPASSWD: ALL
```

Proper Bash errors:
```bash
set -euo pipefail
```
