# .DOTFILES

this repo holds my personal dotfiles for safekeeping and easy installations.
feel free to use or critique my choices.

## installation

installs are performed by bash scripts. the commands run assume you are working
with a clean machine, so they may be desctructive to past configs.

**instructions**
first, clone the repo and move to the directory. then, choose a command.

    git clone https://github.com/e-zim/.DOTFILES.git
    cd .DOTFILES

## commands

### homebrew

if on a mac, homebrew packages can be installed with `./homebrew.sh` and
authenticated with using `./homebrew-login.sh`.

### neovim

configure a nice flavor of neovim using `./nvim.sh setup`. needs neovim v0.9ish.

if neovim isn't available, use `./nvim.sh classic` for a regular `.vimrc`.

### tmux

setup a friendly multiplexer with `./tmux.sh setup`. tmux installed seperately.

modify the configs with `./tmux.sh edit`.
