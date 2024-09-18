#!/usr/bin/env bash

# Display an informative message
function help {
    echo "     copy  share settings with home manager"
    echo "     help  display this informative message"
    echo "   remove  uninstall the nix installation"
    echo "      run  install packaged configurations"
}

# Copy the configs from this repo
function copy {
    rm -f "$HOME/.config/home-manager/home.nix"
    ln -s "$(pwd)/home.nix" "$HOME/.config/home-manager/home.nix"
    home-manager switch
}

# Uninstall the existing Nix installation
function remove {
    /nix/nix-installer uninstall
    rm -rf "$HOME/.local/state/nix"
    rm -rf "$HOME/.local/state/home-manager"
    rm -rf "$HOME/.nix-defexpr"
    rm -f "$HOME/.nix-channels"
    rm -f "$HOME/.nix-profile"
}

# Install a flaked Nix with configuration settings
#
# https://github.com/DeterminateSystems/nix-installer
# https://github.com/nix-community/home-manager
function run {
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    echo "Checking the installed Nix version:"
    nix --version
    echo "Installing the Nix home manager..."
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
    copy
}

# Hint if no command is provided
if [ -z "$1" ]; then
    printf "\x1b[1mEnter a command!\x1b[0;2m $ source setup.sh run\x1b[0m\n"
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
