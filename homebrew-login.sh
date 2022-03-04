#!/bin/bash
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
