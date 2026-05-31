# https://tailscale.com/docs/features/tailscale-serve
{ pkgs, ... }:
{
  systemd.services = {
    "ollama-tailnet" = {
      description = "Expose Ollama to the tailnet via Tailscale Serve";
      wantedBy = [ "multi-user.target" ];
      wants = [
        "caddy.service"
        "network-online.target"
        "ollama.service"
        "tailscaled.service"
      ];
      after = [
        "caddy.service"
        "network-online.target"
        "ollama.service"
        "tailscaled.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.tailscale}/bin/tailscale serve --bg --yes --tcp=11434 tcp://127.0.0.1:11435";
        ExecStop = "${pkgs.tailscale}/bin/tailscale serve --tcp=11434 tcp://127.0.0.1:11435 off";
      };
    };
  };
}
