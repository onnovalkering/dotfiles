# Dotfiles
This is the configuration I use for macOS and some Ubuntu Server instances.

## Notes to self
To add a sshfs mount at startup, add to `/etc/fstab`:

```
<USER>@<HOSTAME>:<SOURCE> <TARGET> fuse.sshfs allow_other,default_permissions,identityfile=<ID_RSA> 0 0
```