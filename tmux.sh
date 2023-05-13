#!/bin/bash -e

# Modify and apply configurations
function edit {
    $EDITOR .tmux.conf
    tmux source .tmux.conf
}

# Display an informative message
function help {
    echo "    edit  modify and reload the config"
    echo "    help  display this informative message"
    echo "   setup  prepare local tmux preferences"
}

# Copy configuration settings
function setup {
    echo -n "Copying configs..."
    cp .tmux.conf $HOME/.tmux.conf
    echo " Done!"
}

# Error if no command is provided
if [ -z "$1" ]
then
    echo "Enter a command! Example: \`./tmux.sh edit\`"
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
fi
