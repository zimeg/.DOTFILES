#!/bin/bash -e

# Display an informative message
function help {
    echo "    clean  reset all existing settings"
    echo "     copy  apply configs to package manager"
    echo "     help  display this informative message"
    echo "    setup  prepare local package preferences"
}

# Reset back to default settings
function clean {
    echo "(TODO)..."
    # rm -rf $HOME/.config/nix
}

# Copy the configs from this repo
function copy {
    echo -n "Linking configs..."
    echo -n " (TODO)..."
    # ln -s $(pwd)/nix $HOME/.config/nix
    echo " Done!"
}

# Copy configuration settings
function setup {
    clean
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    copy
}

# Error if no command is provided
if [ -z "$1" ]
then
    echo "Enter a command! Example: \`./nix.sh setup\`"
    help
    exit 1
fi

# Run the provided command if found
if [[ "$1" ]] && declare -f "$1" > /dev/null
then
    "$@"
else
    echo "Command \`$1\` not found! Try one of the following:"
    help
    exit 1
fi
