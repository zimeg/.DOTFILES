{ nixpkgs, self, ... }@inputs:
{
  "x86_64-linux" =
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
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
                80 # HTTP
                443 # HTTPS
              ];
              allowedUDPPorts = [
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
              "o526.net" = {
                email = "zim@o526.net";
                group = "nginx";
              };
              "dev.o526.net" = {
                email = "zim@o526.net";
                group = "nginx";
              };
              "quintus.sh" = {
                email = "calendar@quintus.sh";
                group = "nginx";
              };
            };
          };
          services.nginx = {
            enable = true;
            virtualHosts = {
              "o526.net" = {
                enableACME = true;
                forceSSL = true;
                locations."/" = {
                  proxyPass = "http://10.100.0.2:4321";
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
              "quintus.sh" = {
                enableACME = true;
                forceSSL = true;
                locations."/" = {
                  proxyPass = "http://10.100.0.2:5000";
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
      image = inputs.nixos-generators.nixosGenerate {
        inherit pkgs;
        format = "amazon";
        modules = [
          configurations
          {
            image.baseName = name;
          }
        ];
      };
      virtualization = "${image}/${name}.vhd";
    in
    {
      tofu = pkgs.writeShellScriptBin "tofu" ''
        export TF_VAR_image="${virtualization}"
        ${pkgs.opentofu}/bin/tofu $@
      '';
      default = self.packages."x86_64-linux".tofu;
    };
}
