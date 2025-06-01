{ config, pkgs, ... }:
{
  system.stateVersion = "24.05";
  nix = {
    gc = {
      automatic = true;
    };
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  imports = [
    ./hardware/configuration
    ./hardware/graphics
    ./hardware/nvidia
    ./programs/gnupg
    ./security/rtkit
    ./security/sudo
    ./services/github-runners
    ./services/interception-tools
    ./services/ollama
    ./services/openssh
    ./services/pipewire
    ./services/plasma6
    ./services/printing
    ./services/pulseaudio
    ./services/sddm
    ./services/tailscale
    ./services/xserver
    ./systemd/services
    ./systemd/targets
    ./systemd/timers
  ];
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 12;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    addDriverRunpath
    parted
    cudaPackages.cuda_cudart
    cudaPackages.cudatoolkit
    linuxPackages.nvidia_x11
  ];
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  networking = {
    hostName = "tom";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      allowedUDPPorts = [
        123
      ];
      allowedTCPPorts = [
        80
        443
        3000
        25565
      ];
    };
  };
  sops = {
    defaultSopsFile = ./secrets/vault.yaml;
    defaultSopsFormat = "yaml";
    age = {
      generateKey = false;
      keyFile = "/home/ez/.config/sops/age/keys.txt";
    };
    secrets = {
      "ai/openai" = {
        owner = config.users.users.default.name;
        group = "wheel";
      };
      "github/runners/coffee" = { };
      "github/runners/dotfiles" = { };
      "github/runners/etime" = { };
      "github/runners/slacks" = { };
    };
  };
  time = {
    timeZone = "America/Los_Angeles";
  };
  users.users.default = {
    isNormalUser = true;
    name = "ez";
    description = "eden";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    linger = true;
    packages = with pkgs; [
      thunderbird
    ];
  };
}
