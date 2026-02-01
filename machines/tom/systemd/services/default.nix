# https://github.com/systemd/systemd
{ pkgs, ... }:
{
  imports = [
    ./blog
    ./quintus
    ./slack
  ];
  systemd.services = {
    nvidia-control-devices = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
      };
    };
  };
}
