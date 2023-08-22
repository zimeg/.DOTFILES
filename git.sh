#!/bin/bash -e

# Display an informative message
function help {
    echo "    clean  reset all existing settings"
    echo "     copy  apply configs to version control"
    echo "     help  display this informative message"
    echo "    setup  prepare local git preferences"
}

# Reset back to default settings
function clean {
    rm -rf $HOME/.gitconfig
    rm -rf $HOME/.gitignore.global
}

# Copy the configs from this repo
function copy {
    echo -n "Linking configs..."
    ln -s $(pwd)/.gitconfig $HOME/.gitconfig
    ln -s $(pwd)/.gitignore.global $HOME/.gitignore.global
    echo " Done!"
}

# Copy configuration settings
function setup {
    clean
    copy
}

# Error if no command is provided
if [ -z "$1" ]
then
    echo "Enter a command! Example: \`./git.sh setup\`"
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
