#!/bin/bash -e

# Display an informative message
function help {
    echo "   clean  uninstall the installation"
    echo "    help  display this informative message"
    echo "   login  authenticate with services"
    echo "  logout  remove local login credentials"
    echo "   setup  download commands and configs"
}

# Remove the local download
function clean {
    echo "💾 Uninstalling Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    echo "💾 Uninstallation complete"
}

# Sign in to internet things
function login {
    printf "🔐 Homebrew authentication\n\n"

    # GATHER BITWARDEN SESSION TOKEN
    printf "🔐 Bitwarden login\n"
    printf "\t📋 if needed, gather \`client_secret\` from the API Key section\n"
    printf "\thttps://vault.bitwarden.com/#/settings/account\n"
    BW_SESSION=`bw login | grep -e "\$ export.*" | cut -d'"' -f 2`

    ## PACKAGE SPECIFIC CONFIGS
    printf "\n👾 Developer settings\n"
    echo "🍾 Homebrew packages"

    echo "🔐 Logging into Shpotify.."
    # https://developer.spotify.com/dashboard/applications
    echo "  ⚙️  Gathering client secrets"
    SPOTIFY_CLIENT_APP=`bw list items --search SPOTIFY_CLI --session $BW_SESSION`
    SPOTIFY_CLIENT_ID=`echo $SPOTIFY_CLIENT_APP | jq .[0].login.username | cut -d'"' -f 2`
    SPOTIFY_CLIENT_SECRET=`echo $SPOTIFY_CLIENT_APP | jq .[0].login.password | cut -d'"' -f 2`
    echo "  ⚙️  Writing client secrets"
    printf "CLIENT_ID=\"$SPOTIFY_CLIENT_ID\"\nCLIENT_SECRET=\"$SPOTIFY_CLIENT_SECRET\"" > $HOME/.shpotify.cfg
    echo "  🔓 Logged into Shpotify"

    echo "🔐 Logging into Github.."
    echo "  ⚙️  Generating ssh key"
    ssh-keygen -t ed25519 -C "ethan.zimbelman@me.com" -f $HOME/.ssh/id_ed25519 -P ""
    printf "Host *\n  AddKeysToAgent yes\n  IdentityFile ~/.ssh/id_ed25519\n" > $HOME/.ssh/config
    printf "\n  ⚙️  Login to Github\n"
    gh auth login
    echo "  🔓 Logged into Github"

    printf "🔐 Successfully created active sessions\n\n"
}

function logout {
    printf "🔐 Removing local Homebrew sessions\n\n"

    printf "🔑 Logging out of Bitwarden\n"
    bw logout # bitwarden-cli

    printf "🔑 Removing Spotify credentials\n"
    rm $HOME/.shpotify.cfg # shpotify

    printf "🔑 Logging out of Github\n"
    gh auth logout # github cli

    printf "🔐 Successfully removed all active sessions\n\n"
}

# Install homebrew and packages
function setup {
    echo "🍎 apple only; for linux, see: https://docs.brew.sh/Homebrew-on-Linux"

    echo "💾 Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    echo "💾 Installing packages"
    brew install bat # https://github.com/sharkdp/bat
    brew install fd # https://github.com/sharkdp/fd
    brew install jq # https://github.com/stedolan/jq
    brew install tmux # https://github.com/tmux/tmux
    brew install wget # https://www.gnu.org/software/wget/

    brew install httpie # https://httpie.io/cli
    brew install ngrok/ngrok/ngrok # https://ngrok.com/docs

    brew tap hashicorp/tap # https://www.terraform.io/
    brew install hashicorp/tap/terraform

    brew install bitwarden-cli # https://github.com/bitwarden/cli
    brew install shpotify # https://github.com/hnarayanan/shpotify
    brew install gh # https://cli.github.com/
    echo "💾 Installation complete"

    echo "🔐 Login to packages with accounts using \`homebrew-login.sh\`"
}

# Error if no command is provided
if [ -z "$1" ]
then
    echo "Enter a command! Example: \`./homebrew.sh setup\`"
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
