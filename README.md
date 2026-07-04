# Dotfiles

These dotfiles were stolen from multiple sources with little to no shame.

```bash
$ cat issues > /dev/null
```

## Install

Install every configuration:

```bash
make install
```

The repository can be cloned anywhere and under any directory name. The
Makefile resolves configuration sources relative to its own location.

Install one configuration:

```bash
make nvim
make doom
make vim
make tmux
make zsh
make git
```

Existing regular files and directories are left untouched. Move or remove a
conflicting destination before installing.
