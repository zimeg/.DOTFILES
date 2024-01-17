#!/bin/bash -e

# Display an informative message
function help {
    echo "    clean  reset all existing settings"
    echo "     copy  apply configs to package manager"
    echo "     help  display this informative message"
    echo "   remove  uninstall the nix installation"
    echo "    setup  prepare local package preferences"
}

# Reset back to default settings
function clean {
    echo "Cleaning past configs... (TODO)..."
    # rm -rf $HOME/.config/nix
    echo "Uninstall Nix with \`source nix.sh remove\`"
}

# Copy the configs from this repo
function copy {
    echo -n "Linking configs..."
    echo -n " (TODO)..."
    # ln -s $(pwd)/nix $HOME/.config/nix
    echo " Done!"
}

# Uninstall the existing Nix installation
function remove {
    /nix/nix-installer uninstall
}

# Copy configuration settings
function setup {
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    echo "Checking the installed Nix version:"
    nix --version
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
