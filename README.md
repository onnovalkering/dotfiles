# Dotfiles
My `$HOME` is a (this) git repository.

```shell
cd $HOME \
  && git init \
  && git remote add origin git@github.com:onnovalkering/dotfiles.git \
  && git fetch \
  && git checkout --force master \
  && .scripts/init.sh
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