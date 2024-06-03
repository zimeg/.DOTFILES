# `neovim`

settings for the terminal editor. note: `alias vim="nvim"`

## classics

systems that request the standard installation of `vim` have hope:

```sh
$ ln -s $HOME/.DOTFILES/.vimrc $HOME/.vimrc
```

## languages

filetype options and language server configurations have some nuace:

- `config/lua/user/files`: autocommand options
- `config/after/plugin/comform`: file formatters
- `config/after/plugin/lsp`: language processing
- `config/after/ftplugin`: setting for plugins

## references

most keymappings are sourced from the internet. here are my sources:

- `kj` movement – [this stackexchange post](https://vi.stackexchange.com/a/18081)
- neovim setup and plugins – [this youtube video](https://youtu.be/w7i4amO_zaE)
- netrw modifications - [this blog post](https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/)
- plugin organization - [these dotfiles](https://github.com/caarlos0/dotfiles/blob/main/modules/neovim/default.nix)
