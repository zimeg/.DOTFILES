# https://nixos.wiki/wiki/Nixos-generate-config
{ config, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/925e1fcc-2949-4446-8ee9-74ca13363858";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/205C-364C";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/30535ff2-b087-45ac-a9cd-cc198dbe7f81";
      fsType = "ext4";
    };
  };
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
  networking = {
    useDHCP = lib.mkDefault true;
  };
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/7d04936f-cc03-4608-980a-fefb503deb6e";
    }
  ];
}
