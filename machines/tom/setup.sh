#!/usr/bin/env bash

# Display this informative message
function help {
    echo "    clean  remove files updated from changes"
    echo "     help  display this informative message"
    echo "     link  use the contained configurations"
    echo "   switch  change to the latest declarations"
}

# Remove files updated from changes
function clean {
    sudo rm -f /etc/nixos/configuration.nix
}

# Use the contained configurations
function link {
    sudo ln -s "$HOME/.DOTFILES/machines/tom/configuration.nix" /etc/nixos/configuration.nix
    switch
}

# Change to the latest declarations
function switch {
    sudo nixos-rebuild switch --flake .#
}

# Hint if no command is provided
if [ -z "$1" ]; then
    printf "\x1b[1mEnter a command!\x1b[0;2m $ bash setup.sh link\x1b[0m\n"
    help
    return 2>/dev/null
    exit 0
fi

# Run the provided command if found
if [[ "$1" ]] && declare -f "$1" >/dev/null; then
    "$@"
else
    printf "\x1b[1mCommand \x1b[2m%s\x1b[0;1m not found! Try one of the following:\x1b[0m\n" "$1"
    help
    return 1 2>/dev/null
    exit 1
fi
