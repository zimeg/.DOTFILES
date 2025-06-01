# https://nixos.wiki/wiki/Nvidia
{ config, ... }:
{
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
