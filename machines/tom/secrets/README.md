# secrets

tokens. passwords. `********`. setup:

```sh
$ mkdir -p ~/.config/sops/age
$ bw get item age.tom | jq -r .notes > ~/.config/sops/age/keys.txt
$ chmod 600 ~/.config/sops/age/keys.txt
$ sops vault.yaml
```
