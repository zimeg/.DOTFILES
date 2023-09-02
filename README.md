# .DOTFILES

this repo holds my personal dotfiles for safekeeping and easy installations.
feel free to use or critique my choices.

## installation

installs are performed by bash scripts. the commands run assume you are working
with a clean machine, so they may be desctructive to past configs.

**instructions**
first, clone the repo and prepare the directory. then, choose a command.

    git clone https://github.com/zimeg/.DOTFILES.git
    cd .DOTFILES
    git submodule init

## commands

### git

version controlled configs for a version control system can be setup with the
`git.sh setup` script.

### homebrew

if on a mac, info on the homebrew setup can be found with `./homebrew.sh help`.

### neovim

configure a nice flavor of neovim using `./nvim.sh setup`. needs neovim v0.9ish.

if neovim isn't available, use `./nvim.sh classic` for a regular `.vimrc`.

### tmux

setup a friendly multiplexer with `./tmux.sh setup`. tmux installed seperately.

modify the configs with `./tmux.sh edit`.
