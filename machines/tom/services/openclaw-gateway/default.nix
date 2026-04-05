# https://github.com/openclaw/openclaw
{ ... }:
{
  services.openclaw-gateway = {
    enable = true;
    port = 18789;
    user = "openclaw";
    group = "openclaw";
    stateDir = "/var/lib/openclaw";
    environment = {
      NODE_ENV = "production";
    };
  };
}
