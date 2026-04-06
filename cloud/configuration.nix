{ nixpkgs, self, ... }:
{
  "x86_64-linux" =
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      configurations =
        { config, ... }:
        {
          system = {
            stateVersion = "25.11";
          };
          nix.registry = {
            nixpkgs.flake = nixpkgs;
          };
          environment = {
            etc = {
              "nixos/vault.yaml" = {
                source = ./secrets/vault.yaml;
              };
            };
          };
          networking = {
            hostName = "web";
            useNetworkd = true;
            firewall = {
              enable = true;
              allowedTCPPorts = [
                22 # SSH
                80 # HTTP
                443 # HTTPS
                25565 # Minecraft
              ];
              allowedUDPPorts = [
                123 # NTP
                51820 # WireGuard
              ];
            };
            networkmanager = {
              enable = false;
            };
            wg-quick = {
              interfaces.wg0 = {
                address = [ "10.100.0.1/32" ];
                listenPort = 51820;
                privateKeyFile = "/run/secrets/wg.key";
                peers = [
                  {
                    publicKey = "19AwxIeixbvthKYXYlUnqjvd9JghNOAMYVIpLppdQgo=";
                    allowedIPs = [ "10.100.0.2/32" ];
                  }
                ];
              };
            };
          };
          security.acme = {
            acceptTerms = true;
            certs = {
              "api.o526.net" = {
                email = "zim@o526.net";
                group = "nginx";
              };
              "dev.o526.net" = {
                email = "zim@o526.net";
                group = "nginx";
              };
              "tom.o526.net" = {
                email = "zim@o526.net";
                group = "nginx";
              };
              "o526.net" = {
                email = "zim@o526.net";
                group = "nginx";
              };
              "quintus.sh" = {
                email = "calendar@quintus.sh";
                group = "nginx";
              };
              "todos.guide" = {
                email = "hello@todos.guide";
                group = "nginx";
              };
            };
          };
          services.nginx = {
            enable = true;
            streamConfig = ''
              upstream minecraft {
                server 10.100.0.2:25565;
              }
              server {
                listen 25565;
                proxy_pass minecraft;
              }
              upstream ntp {
                server 10.100.0.2:123;
              }
              server {
                listen 123 udp;
                proxy_pass ntp;
                proxy_responses 1;
                proxy_timeout 3s;
              }
              upstream ssh {
                server 10.100.0.2:23231;
              }
              server {
                listen 22;
                proxy_pass ssh;
              }
            '';
            virtualHosts = {
              "api.o526.net" = {
                enableACME = true;
                forceSSL = true;
                locations."/" = {
                  proxyPass = "http://10.100.0.2:8083";
                  proxyWebsockets = false;
                };
              };
              "dev.o526.net" = {
                enableACME = true;
                forceSSL = true;
                locations."/" = {
                  proxyPass = "http://10.100.0.2:3000";
                  proxyWebsockets = true;
                };
              };
              "tom.o526.net" = {
                enableACME = true;
                forceSSL = true;
                locations."/slack/events" = {
                  proxyPass = "http://10.100.0.2:18789";
                  proxyWebsockets = false;
                  extraConfig = ''
                    proxy_set_header x-forwarded-user "slack";
                  '';
                };
              };
              "o526.net" = {
                enableACME = true;
                forceSSL = true;
                locations."/" = {
                  proxyPass = "http://10.100.0.2:4321";
                  proxyWebsockets = false;
                };
              };
              "quintus.sh" = {
                enableACME = true;
                forceSSL = true;
                locations."/" = {
                  proxyPass = "http://10.100.0.2:5000";
                  proxyWebsockets = false;
                };
              };
              "todos.guide" = {
                enableACME = true;
                forceSSL = true;
                locations."/" = {
                  proxyPass = "http://10.100.0.2:8082";
                  proxyWebsockets = false;
                };
              };
            };
          };
          systemd = {
            network = {
              enable = true;
              wait-online = {
                enable = true;
              };
              networks."10-ec2" = {
                matchConfig = {
                  Name = "ens5";
                };
                networkConfig = {
                  DHCP = "ipv4";
                  IPv6AcceptRA = false;
                };
              };
            };
            services = {
              "sops-nix" = {
                description = "Unlock the vaults";
                wantedBy = [ "multi-user.target" ];
                wants = [ "network-online.target" ];
                after = [ "network-online.target" ];
                serviceConfig = {
                  Type = "oneshot";
                  RemainAfterExit = true;
                };
                path = [
                  pkgs.sops # https://github.com/getsops/sops
                  pkgs.yq-go # https://github.com/mikefarah/yq
                ];
                script = ''
                  mkdir -p /run/secrets
                  sops -d /etc/nixos/vault.yaml | \
                    yq eval '.wireguard.private' - > /run/secrets/wg.key
                  chmod 0400 /run/secrets/wg.key
                  chown root:root /run/secrets/wg.key
                '';
              };
              "wg-quick-wg0" = {
                requires = [ "sops-nix.service" ];
                after = [ "sops-nix.service" ];
              };
            };
          };
          time = {
            timeZone = "Etc/UTC";
          };
          users = {
            users.nginx.extraGroups = [ "acme" ];
          };
          virtualisation = {
            diskSize = 4 * 1024;
          };
        };
      name = "web-${system}";
      imageCfg = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          configurations
          "${nixpkgs}/nixos/maintainers/scripts/ec2/amazon-image.nix"
          {
            image.baseName = name;
          }
        ];
      };
      image = imageCfg.config.system.build.amazonImage;
      virtualization = "${image}/${imageCfg.config.image.fileName}";
    in
    {
      tofu = pkgs.writeShellScriptBin "tofu" ''
        export TF_VAR_image="${virtualization}"
        ${pkgs.opentofu}/bin/tofu $@
      '';
      default = self.packages."x86_64-linux".tofu;
    };
}
