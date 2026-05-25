# https://tailscale.com/docs/features/tailscale-serve
{ pkgs, ... }:
{
  systemd.services = {
    "ollama-tailnet" = {
      description = "Expose Ollama to the tailnet via Tailscale Serve";
      wantedBy = [ "multi-user.target" ];
      wants = [
        "network-online.target"
        "ollama.service"
        "tailscaled.service"
      ];
      after = [
        "network-online.target"
        "ollama.service"
        "tailscaled.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.tailscale}/bin/tailscale serve --bg --yes --https=8443 http://127.0.0.1:11434";
        ExecStop = "${pkgs.tailscale}/bin/tailscale serve --https=8443 off";
      };
    };
  };
}
