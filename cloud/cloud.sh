#!/usr/bin/env bash

TF_VAR_hosted_zone_id=$(jq -r .hosted_zone_id tofu.auto.tfvars.json)

# Display an informative message
function help {
    echo "    apply  update any changed infrastructure"
    echo "    check  verify formatting meets standards"
    echo "    clean  reset the working file directory"
    echo "     help  display this informative message"
    echo "     init  setup existing cloud configurations"
    echo "     plan  preview any configuration changes"
}

# Update infrastructure with any state changes
function apply {
    nix run .# apply
}

# Ensure formatting matches a statand
function check {
    nix run .# fmt -check
    nix run .# validate
}

# Reset back to a clean directory
function clean {
    rm -rf .terraform
    rm -f terraform.tfstate*

    echo "provisioned resources remain safe and unchanged"
    echo "  carefully remove these with \`tofu destroy\`"
}

# Setup the current state
function init {
    rm -f terraform.tfstate terraform.tfstate.backup
    nix run .# init
}

# Preview any changes to the configurations
function plan {
    nix run .# plan
}

# Hint if no command is provided
if [ -z "$1" ]; then
    printf "\x1b[1mEnter a command!\x1b[0;2m $ ./cloud.sh sync\x1b[0m\n"
    help
    return 2>/dev/null
    exit 0
fi

# Run the provided command if found
if [[ "$1" ]] && declare -f "$1" >/dev/null; then
    "$@"
else
    printf "\x1b[1mCommand \x1b[2m%s\x1b[0;1m not found! Try one of the following:\x1b[0m\n" "$1"
    help
    return 1 2>/dev/null
    exit 1
fi
