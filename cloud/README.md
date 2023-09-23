# `cloud`

configurations for any managed infrastructure is done by code. this is usually
easier to adjust than from the guis.

this directory contains all of the configurations for resources shared between
projects.

## getting started

to quickly synchronize and verify state, try:

```sh
$ ./cloud.sh sync
$ ./cloud.sh plan
```

more useful commands can be discovered with:

```sh
$ ./cloud.sh help
```

## managed state

the `terraform.tfstate` file holds the most recent changes on the cloud but can
contain secrets and shouldn't be committed.

a hosted state backend is used instead to synchronize changes across multiple
machines by exchanging the most recent state.

specifics of the implementation is contained in `state.tf`.

### command setup

build the latest version of [opentofu][opentofu] and create an alias to `tofu`:

```sh
# https://github.com/opentofu/opentofu/blob/main/BUILDING.md
$ mkdir -p ~/go/src/github.com/opentofu
$ cd ~/go/src/github.com/opentofu
$ git clone https://github.com/opentofu/opentofu
$ cd opentofu
$ go build -ldflags "-w -s -X 'github.com/opentofu/opentofu/version.dev=no'" -o bin/tofu .
$ ln -s $(pwd)/bin/tofu /usr/local/bin/tofu
```

### collecting state

projects using a managed infrastructure can connect to this backend by adding
the following to `main.tf`:

```hcl
terraform {
  # ...
  backend "s3" {
    bucket = "architectf"
    key    = "project-name-here" # Replace this!
    region = "us-east-1"
    dynamodb_table = "architectf-timeline"
  }
}
```

<!-- a collection of links -->
[opentofu]: https://github.com/opentofu/opentofu
