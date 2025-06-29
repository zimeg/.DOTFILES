# https://nixos.wiki/wiki/Nixos-generate-config
{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/dbdc1b92-41ef-40f3-9182-b8b6d591b5eb";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/dbdc1b92-41ef-40f3-9182-b8b6d591b5eb";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };
    "/persistent" = {
      device = "/dev/disk/by-uuid/dbdc1b92-41ef-40f3-9182-b8b6d591b5eb";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "subvol=persistent" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/FC97-97E8";
      fsType = "vfat";
      options = [
        "dmask=0022"
        "fmask=0022"
      ];
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
      device = "/dev/disk/by-uuid/7e2ef539-f5a8-4ad4-aee0-f8b80121647b";
    }
  ];
}
