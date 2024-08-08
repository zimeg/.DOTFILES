{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  system.stateVersion = "24.05";
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;
  imports = [
    (import "${home-manager}/nixos")
    ./hardware/configuration
    (import ./hardware/nvidia { config = config; })
    ./hardware/opengl
    ./hardware/pulseaudio
    ./programs/gnupg
    ./security/rtkit
    (import ./services/interception-tools { pkgs = pkgs; })
    ./services/ollama
    ./services/openssh
    ./services/pipewire
    ./services/plasma6
    ./services/printing
    ./services/sddm
    ./services/xserver
    (import ./systemd/services { pkgs = pkgs; })
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
      };
    };
  };
  environment.systemPackages = with pkgs; [
    addOpenGLRunpath
    cudaPackages.cuda_cudart
    cudaPackages.cudatoolkit
    linuxPackages.nvidia_x11
  ];
  home-manager.users.default = {
    imports = [ ../../programs/home.nix ];
  };
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
      allowedTCPPorts = [
        80
        443
        25565
      ];
    };
  };
  time = {
    timeZone = "America/Los_Angeles";
  };
  users.users.default = {
    isNormalUser = true;
    name = "ez";
    description = "eden";
    extraGroups = [ "networkmanager" "wheel" ];
    linger = true;
    packages = with pkgs; [
      thunderbird
    ];
  };
}
