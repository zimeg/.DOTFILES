#!/bin/bash
printf "🔐 Removing local Homebrew sessions\n\n"

printf "🔑 Logging out of Bitwarden\n"
bw logout # bitwarden-cli

printf "🔑 Removing Spotify credentials\n"
rm $HOME/.shpotify.cfg # shpotify

printf "🔑 Logging out of Github\n"
gh auth logout # github cli

printf "🔐 Successfully removed all active sessions\n\n"
