#!/bin/bash -e

# Display an informative message
function help {
    echo "    edit  modify and reload the config"
    echo "    help  display this informative message"
    echo "   setup  prepare local nvim preferences"
}

# Copy configuration settings
function setup {
    echo -n "Copying configs..."
    mkdir -p $HOME/.config
    cp -r nvim  $HOME/.config
    echo " Done!"
}

# Modify and apply configurations
function edit {
    $EDITOR nvim # TODO
    setup # TODO source?
}

# Error if no command is provided
if [ -z "$1" ]
then
    echo "Enter a command! Example: \`./nvim.sh edit\`"
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
