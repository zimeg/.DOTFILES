# https://github.com/charmbracelet/soft-serve
{ config, lib, ... }:
let
  cfg = config.services.soft-serve;
in
{
  services.soft-serve = {
    enable = true;
    settings = {
      name = "Git for TOM";
      ssh = {
        listen_addr = ":23231";
        public_url = "ssh://git.o526.net";
      };
      git = {
        enabled = false;
      };
      http = {
        enabled = false;
      };
      stats = {
        enabled = false;
      };
      initial_admin_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWGLeFO/h/8B3u8gq6N1s1/sHnQK7Su7+4elRm3eS4W"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZQSWnGNtSoSAaK90h3FYsxTlevad8+BpTzR2DwiT1C"
      ];
    };
  };
  systemd.services.soft-serve.serviceConfig = {
    DynamicUser = lib.mkForce false;
    ExecStart = lib.mkForce "${lib.getExe cfg.package} serve --sync-hooks";
    UMask = lib.mkForce "0022";
    User = "git";
    Group = "git";
  };
}
