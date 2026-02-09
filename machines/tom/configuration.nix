{ config, pkgs, ... }:
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
    allowUnfreePredicate =
      pkg:
      builtins.elem (pkgs.lib.getName pkg) [
        "cuda_cccl"
        "cuda_cudart"
        "cuda_cuobjdump"
        "cuda_cupti"
        "cuda_cuxxfilt"
        "cuda_gdb"
        "cuda_nvcc"
        "cuda_nvdisasm"
        "cuda_nvml_dev"
        "cuda_nvprune"
        "cuda_nvrtc"
        "cuda_nvtx"
        "cuda_profiler_api"
        "cuda_sanitizer_api"
        "cuda-merged"
        "cudnn"
        "libcublas"
        "libcufft"
        "libcusparse"
        "libcurand"
        "libcusolver"
        "libnpp"
        "libnvjitlink"
        "minecraft-server"
        "nvidia-settings"
        "nvidia-x11"
      ];
    cudaCapabilities = [ "8.6" ];
    cudaForwardCompat = true;
    cudaSupport = true;
  };
  imports = [
    ./hardware/configuration
    ./hardware/graphics
    ./hardware/nvidia
    ./programs/git
    ./programs/gnupg
    ./security/polkit
    ./security/rtkit
    ./security/sudo
    ./services/github-runners
    ./services/interception-tools
    ./services/minecraft-server
    ./services/ollama
    ./services/openssh
    ./services/pipewire
    ./services/plasma6
    ./services/printing
    ./services/pulseaudio
    ./services/restic
    ./services/sddm
    ./services/tailscale
    ./services/xserver
    ./systemd/services
    ./systemd/targets
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
      "/etc/ollama/models"
      "/srv/minecraft/world"
      "/var/lib/nixos"
      "/var/lib/slack"
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
      directories = [
        ".DOTFILES"
        ".local/share/direnv"
        ".ssh"
        "programming"
      ];
      files = [
        ".config/zsh/.zsh_history"
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    addDriverRunpath
    parted
    restic
    unzip
    zip
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
      allowedTCPPorts = [
        80 # HTTP
        443 # HTTPS
        3000 # Development
        4321 # Blog
        5000 # Quintus
        8082 # Todo's Guide
      ];
      allowedUDPPorts = [
        123 # NTP
        51820 # Wireguard
      ];
    };
    wireguard = {
      interfaces.wg0 = {
        ips = [ "10.100.0.2/32" ];
        listenPort = 51820;
        privateKeyFile = config.sops.secrets."tom/wireguard/private".path;
        peers = [
          {
            publicKey = "welnsS1YyVGjciqlyx8w5GlmTz/x25LQlVkQMFzr6zE=";
            allowedIPs = [ "10.100.0.1/32" ];
            endpoint = "tom.o526.net:51820";
            persistentKeepalive = 25;
          }
        ];
      };
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
      "ai/credentials" = {
        owner = config.users.users.default.name;
        group = "wheel";
        format = "json";
        key = "";
        path = "${config.users.users.default.home}/.local/share/opencode/auth.json";
        sopsFile = ./programs/opencode/vault.json;
      };
      "aws/credentials" = {
        owner = config.users.users.default.name;
        group = "wheel";
        format = "json";
        key = "";
        sopsFile = ./programs/awscli/vault.json;
      };
      "aws/iam/minecraft" = {
        format = "dotenv";
        owner = "minecraft";
        group = "minecraft";
        sopsFile = ./services/minecraft-server/vault.env;
      };
      "github/oauth" = {
        owner = config.users.users.default.name;
        group = "wheel";
      };
      "github/runners/blog" = {
        owner = "blog";
        group = "blog";
      };
      "github/runners/coffee" = {
        owner = "coffee";
        group = "coffee";
      };
      "github/runners/dotfiles" = {
        owner = "dotfiles";
        group = "dotfiles";
      };
      "github/runners/etime" = {
        owner = "etime";
        group = "etime";
      };
      "github/runners/quintus" = {
        owner = "quintus";
        group = "quintus";
      };
      "github/runners/slacks/mercury" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/venus" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/earth" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/mars" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/jupiter" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/saturn" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/uranus" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/neptune" = {
        owner = "slacks";
        group = "slacks";
      };
      "github/runners/slacks/pluto" = {
        owner = "slacks";
        group = "slacks";
      };
      "restic/minecraft" = {
        owner = "minecraft";
        group = "minecraft";
      };
      "slack/snaek" = {
        format = "dotenv";
        owner = "snaek";
        group = "snaek";
        sopsFile = ./systemd/services/slack/snaek/vault.env;
      };
      "slack/tails" = {
        format = "dotenv";
        owner = "tails";
        group = "tails";
        sopsFile = ./systemd/services/slack/tails/vault.env;
      };
      "slack/todos" = {
        format = "dotenv";
        owner = "todos";
        group = "todos";
        sopsFile = ./systemd/services/slack/todos/vault.env;
      };
      "tailscale/auth" = {
        owner = "root";
        group = "root";
      };
      "tom/password" = {
        owner = "root";
        group = "root";
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
        mode = "0644";
        path = "${config.users.users.default.home}/.ssh/id_ed25519.pub";
      };
      "tom/ssh/private" = {
        owner = config.users.users.default.name;
        group = "wheel";
        path = "${config.users.users.default.home}/.ssh/id_ed25519";
      };
      "tom/ssh/host/ed25519/public" = {
        owner = "root";
        group = "root";
        mode = "0644";
        path = "/etc/ssh/ssh_host_ed25519_key.pub";
      };
      "tom/ssh/host/ed25519/private" = {
        owner = "root";
        group = "root";
        path = "/etc/ssh/ssh_host_ed25519_key";
      };
      "tom/ssh/host/rsa/public" = {
        owner = "root";
        group = "root";
        mode = "0644";
        path = "/etc/ssh/ssh_host_rsa_key.pub";
      };
      "tom/ssh/host/rsa/private" = {
        owner = "root";
        group = "root";
        path = "/etc/ssh/ssh_host_rsa_key";
      };
      "tom/wireguard/private" = {
        mode = "0400";
        owner = "root";
        group = "root";
        path = "/run/secrets/wg.key";
      };
    };
  };
  time = {
    timeZone = "America/Los_Angeles";
  };
  users = {
    users = {
      default = {
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
          fastfetch # https://github.com/fastfetch-cli/fastfetch
          wireguard-tools # https://git.zx2c4.com/wireguard-tools
        ];
      };
      blog = {
        isSystemUser = true;
        group = "blog";
      };
      coffee = {
        isSystemUser = true;
        group = "coffee";
      };
      dotfiles = {
        isSystemUser = true;
        group = "dotfiles";
      };
      etime = {
        isSystemUser = true;
        group = "etime";
      };
      quintus = {
        isSystemUser = true;
        group = "quintus";
      };
      slacks = {
        isSystemUser = true;
        group = "slacks";
      };
      snaek = {
        isSystemUser = true;
        group = "snaek";
        home = "/var/cache/snaek";
      };
      tails = {
        isSystemUser = true;
        group = "tails";
        home = "/var/cache/tails";
      };
      todos = {
        isSystemUser = true;
        group = "todos";
        home = "/var/cache/todos";
      };
    };
    groups = {
      blog = { };
      coffee = { };
      dotfiles = { };
      etime = { };
      quintus = { };
      slacks = { };
      snaek = { };
      tails = { };
      todos = { };
    };
  };
}
