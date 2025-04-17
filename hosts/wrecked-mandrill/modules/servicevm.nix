{
  lib,
  config,
  ...
}: {
  options.servicevm = lib.mkOption {
    description = "Define services as microvms for homelab";
    type = with lib.types;
      attrsOf (submodule {
        options = {
          mac = lib.mkOption {
            type = str;
            description = ''
              Mac address of the new machine:
              Get a random here: https://olavmrk.github.io/html-macgen/
            '';
          };
          ip = lib.mkOption {
            type = str;
          };
          config = lib.mkOption {
            type = anything;
          };
        };
      });
  };

  config.microvm.vms =
    lib.attrsets.mapAttrs (name: cfg: {
      config =
        lib.recursiveUpdate {
          system.stateVersion = lib.trivial.release;

          # It is highly recommended to share the host's nix-store
          # with the VMs to prevent building huge images.
          microvm.shares = [
            {
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "virtiofs";
            }
          ];

          microvm.interfaces = [
            {
              # https://olavmrk.github.io/html-macgen/
              type = "macvtap";
              id = "${name}-tap";
              mac = cfg.mac;

              macvtap = {
                link = "services";
                mode = "bridge";
              };
            }
          ];

          networking.nftables.enable = true;

          systemd.network.enable = true;
          systemd.network.networks."20-lan" = {
            matchConfig.Type = "ether";
            dns = ["10.123.0.1" "fe80::7845:58ff:fee4:3cfe"];
            networkConfig = {
              IPv6AcceptRA = true;
            };
            address = [
              "${cfg.ip}/24"
            ];
            gateway = [
              "10.123.0.1"
            ];
          };

          users.mutableUsers = false;

          services.openssh = {
            enable = true;
            settings = {
              PermitRootLogin = "no";
              PasswordAuthentication = false;
              KbdInteractiveAuthentication = false;
            };
          };

          users.users.kim = config.users.users.kim;
          security.sudo.extraRules = config.security.sudo.extraRules;
        }
        cfg.config;
    })
    config.servicevm;
}
