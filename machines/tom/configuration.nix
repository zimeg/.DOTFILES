{
  config,
  lib,
  pkgs,
  ...
}:
{
  system.stateVersion = "25.05";
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
    initrd = {
      postResumeCommands = builtins.readFile ./start.sh;
    };
  };
  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/lib/sops-nix/key.txt";
        parentDirectory = {
          mode = "0700";
        };
      }
    ];
    users.default = {
      home = "/home/ez";
      directories = [
        ".DOTFILES"
        ".local/share/direnv"
        ".ssh"
        "productions"
        "programming"
      ];
      files = [
        ".config/gh/hosts.yml"
        ".config/zsh/.zsh_history"
        ".warprc"
      ];
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
      keyFile = "/var/lib/sops-nix/key.txt";
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
      "tom/password" = {
        neededForUsers = true;
      };
      "tom/sops/private" = {
        owner = config.users.users.default.name;
        group = "wheel";
        path = "${config.users.users.default.home}/.config/sops/age/keys.txt";
      };
      "tom/ssh/public" = {
        owner = config.users.users.default.name;
        group = "wheel";
        path = "${config.users.users.default.home}/.ssh/id_ed25519.pub";
      };
      "tom/ssh/private" = {
        owner = config.users.users.default.name;
        group = "wheel";
        path = "${config.users.users.default.home}/.ssh/id_ed25519";
      };
      "tom/ssh/host/ed25519/public" = {
        path = "/etc/ssh/ssh_host_ed25519_key.pub";
      };
      "tom/ssh/host/ed25519/private" = {
        path = "/etc/ssh/ssh_host_ed25519_key";
      };
      "tom/ssh/host/rsa/public" = {
        path = "/etc/ssh/ssh_host_rsa_key.pub";
      };
      "tom/ssh/host/rsa/private" = {
        path = "/etc/ssh/ssh_host_rsa_key";
      };
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
    hashedPasswordFile = config.sops.secrets."tom/password".path;
    linger = true;
    packages = with pkgs; [
      thunderbird
    ];
  };
}
