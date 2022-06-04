#!/bin/bash
echo "🍎 apple only; for linux, see: https://docs.brew.sh/Homebrew-on-Linux"

echo "💾 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "💾 Installing packages"
brew install tmux # https://github.com/tmux/tmux
cp .tmux.conf ../.tmux.conf
brew install jq # https://github.com/stedolan/jq
brew install bat # https://github.com/sharkdp/bat
brew install ngrok/ngrok/ngrok # https://ngrok.com/docs
brew install httpie # https://httpie.io/cli

brew tap hashicorp/tap # https://www.terraform.io/
brew install hashicorp/tap/terraform

brew install bitwarden-cli # https://github.com/bitwarden/cli
brew install shpotify # https://github.com/hnarayanan/shpotify
brew install gh # https://cli.github.com/
echo "💾 Installation complete"

echo "🔐 Login to packages with accounts using \`homebrew-login.sh\`"
