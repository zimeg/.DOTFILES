# https://github.com/tailscale/tailscale
{
  services.tailscale = {
    enable = true;
    authKeyFile = "/run/secrets/tailscale/auth";
  };
}
