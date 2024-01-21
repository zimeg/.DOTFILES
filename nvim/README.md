# `nvim`

settings for the terminal editor. note: `alias vim="nvim"`

## requisites

for a successful install, make sure the following is tried:

* `:PackerSync` packages plugins and other dependencies
* `:TSInstall` provides parsers for programming languages
* `:checkhealth` returns few or hopefully no errors

if packer hasn't yet been installed, download a copy with:

```sh
$ git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim 2> /dev/null
```

### classics

systems that request the standard installation of `vim` have hope:

```sh
$ ln -s $HOME/.DOTFILES/.vimrc $HOME/.vimrc
```

### removals

if things aren't working out, generated configurations can be rid:

```sh
$ rm -rf $HOME/.config/nvim
$ rm -rf $HOME/.local/share/nvim
```

## references

most keymappings are sourced from the internet. here are my sources:

* `kj` movement – [this stackexchange post](https://vi.stackexchange.com/a/18081)
* neovim setup and plugins – [this youtube video](https://youtu.be/w7i4amO_zaE)
* netrw modifications - [this blog post](https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/)
