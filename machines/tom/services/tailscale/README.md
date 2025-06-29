# tailscale

spikes of network

## authentication

reusable tokens are rotated on restarts for ephermal runner tom server:

1. visit [add linux server][authentication] page
2. check **ephemeral** and **reusable**
3. generate install script for `key`
4. save tokens in the secrets `vault.yaml`

[authentication]: https://login.tailscale.com/admin/machines/new-linux
