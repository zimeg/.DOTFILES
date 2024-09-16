# .DOTFILES

this repo holds my personal dotfiles for safekeepings and simple installations.
feel free to use or critique my choices.

## installation

installs are performed by bash scripts. the commands run assume you are working
with a clean machine, so might be desctructive to past configs.

```sh
$ git clone https://github.com/zimeg/.DOTFILES.git
$ cd .DOTFILES
```

## configurations

### cloud

infrastructure state and setup for shared resources is managed from the `cloud`
directory with `./cloud.sh`.

### machines

computers with coded configuration are saved for setup in `machines` and are
built with the flake derivation.

### programs

a functional and deterministic package manager to manage `programs`. use nix
with: `source setup.sh run`.
