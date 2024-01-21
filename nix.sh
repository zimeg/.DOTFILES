#!/bin/bash -e

# Display an informative message
function help {
    echo "     copy  share settings with home manager"
    echo "     help  display this informative message"
    echo "   remove  uninstall the nix installation"
    echo "    setup  prepare local package preferences"
}

# Copy the configs from this repo
function copy {
    rm -f $HOME/.config/home-manager/home.nix
    ln -s $(pwd)/nix/home.nix $HOME/.config/home-manager/home.nix
    home-manager switch
}

# Uninstall the existing Nix installation
function remove {
    /nix/nix-installer uninstall
    rm -rf $HOME/.local/state/nix
    rm -rf $HOME/.local/state/home-manager
    rm -rf $HOME/.nix-defexpr
    rm -f $HOME/.nix-channels
    rm -f $HOME/.nix-profile
}

# Copy configuration settings
#
# https://github.com/DeterminateSystems/nix-installer
# https://github.com/nix-community/home-manager
function setup {
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    echo "Checking the installed Nix version:"
    nix --version
    echo "Installing the Nix home manager..."
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
    rm result
    copy
}

# Error if no command is provided
if [ -z "$1" ]
then
    echo "Enter a command! Example: \`source nix.sh setup\`"
    help
    return
fi

# Run the provided command if found
if [[ "$1" ]] && declare -f "$1" > /dev/null
then
    "$@"
else
    echo "Command \`$1\` not found! Try one of the following:"
    help
    return 1
fi
