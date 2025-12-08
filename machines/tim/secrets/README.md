# secrets

environment. variables. `********`. setup:

```sh
$ mkdir -p "$HOME/Library/Application Support/sops/age"
$ bw get item age.tim | jq -r .notes > "$HOME/Library/Application Support/sops/age/keys.txt"
$ chmod 600 "$HOME/Library/Application Support/sops/age/keys.txt"
$ sops vault.yaml
```
