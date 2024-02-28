# .DOTFILES

this repo holds my personal dotfiles for safekeeping and easy installations.
feel free to use or critique my choices.

## installation

installs are performed by bash scripts. the commands run assume you are working
with a clean machine, so they may be desctructive to past configs.

**instructions**
first, clone the repo and prepare the directory. then, choose a command.

```sh
$ git clone https://github.com/zimeg/.DOTFILES.git
$ cd .DOTFILES
```

## commands

### git

version controlled configs for a version control system can be setup with the
`git.sh setup` script.

### neovim

a nice flavor of `neovim` is configured with `nix`. a fallback `.vimrc` remains
available.

### tmux

the friendly multiplexer called `tmux` is provided in the `nix` configurations.

## configurations

### cloud

infrastructure state and setup for shared resources is managed from the `cloud`
directory with `./cloud.sh`.

### homebrew

if on a mac, info on the homebrew setup can be found with `./homebrew.sh help`.

### nix

a functional and deterministic package manager to manage other configurations.
