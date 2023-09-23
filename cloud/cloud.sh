#!/bin/bash -e

TF_STATE_BUCKET=$(jq -r .state_bucket tofu.auto.tfvars.json)
TF_STATE_TABLE=$(jq -r .state_lock_table tofu.auto.tfvars.json)

# Display an informative message
function help {
    echo "    apply  update any changed infrastructure"
    echo "    check  verify formatting meets standards"
    echo "    clean  reset the working file directory"
    echo "     help  display this informative message"
    echo "     plan  preview any configuration changes"
    echo "     sync  collect current cloud configurations"
}

# Update infrastructure with any state changes
function apply {
    tofu apply
}

# Ensure formatting matches a statand
function check {
    tofu fmt -check
    tofu validate
}

# Reset back to a clean directory
function clean {
    rm -rf .terraform
    rm -f terraform.tfstate*

    echo "provisioned resources remain safe and unchanged"
    echo " carefully remove these with \`terraform destroy\`"
}

# Preview any changes to the configurations
function plan {
    tofu plan
}

# Collect the current state
function sync {
    rm -f terraform.tfstate terraform.tfstate.backup

    tofu init

    tofu import aws_s3_bucket.tf_state $TF_STATE_BUCKET
    tofu import aws_s3_bucket_ownership_controls.tf_state_controls $TF_STATE_BUCKET
    tofu import aws_s3_bucket_versioning.tf_state_versioning $TF_STATE_BUCKET
    tofu import aws_s3_bucket_acl.tf_state_acl $TF_STATE_BUCKET

    tofu import aws_dynamodb_table.dynamodb_tf_state_lock $TF_STATE_TABLE
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
