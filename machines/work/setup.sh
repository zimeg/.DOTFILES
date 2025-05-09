#!/usr/bin/env bash

# Display this informative message
function help {
    echo "     help  display this informative message"
    echo "  install  download tooling for dependencies"
    echo "   switch  change to the latest declarations"
    echo "uninstall  remove the packages configured"
}

# Download tooling for dependencies
function install {
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
    nix run nix-darwin/master#darwin-rebuild -- switch --flake .#"$(hostname)"
}

# Change to the latest declarations
function switch {
    mv ~/.ssh/config ~/.ssh/config.ts
    mv ~/.ssh/config.hm ~/.ssh/config
    trap '
        mv ~/.ssh/config ~/.ssh/config.hm
        mv ~/.ssh/config.ts ~/.ssh/config
    ' EXIT
    darwin-rebuild switch --flake .#"$(hostname)"
}

# Remove the packages configured
function uninstall {
    nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
    /nix/nix-installer uninstall
}

# Hint if no command is provided
if [ -z "$1" ]; then
    printf "\x1b[1mEnter a command!\x1b[0;2m $ setup.sh switch\x1b[0m\n"
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
