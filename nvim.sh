#!/bin/bash -e

# Display an informative message
function help {
    echo "    clean  reset all existing settings"
    echo "     copy  apply configs to the editor"
    echo "     edit  modify and reload the config"
    echo "  install  download additional plugins"
    echo "     help  display this informative message"
    echo "    setup  prepare local nvim preferences"
}

# Reset back to default settings
function clean {
    rm -rf $HOME/.config/nvim
    rm -rf $HOME/.local/share/nvim
}

# Copy the configs from this repo
function copy {
    echo -n "Copying configs..."
    mkdir -p $HOME/.config
    cp -r nvim $HOME/.config
    echo " Done!"
}

# Download remote plugins
function install {
    rm -rf $HOME/.local/share/nvim # Avoid overwriting...

    echo -n "Cloning plugins..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim 2> /dev/null
    echo " Done!"
    echo "TODO: Run :PackerSync to complete installation!"
}

# Copy configuration settings
function setup {
    clean
    copy
    install
}

# Modify and apply configurations
function edit {
    $EDITOR nvim # TODO: open the directory
    copy
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
