{
  lib,
  config,
  pkgs,
  ...
}: {
  microvm.vms = {
    dns = {
      config = {
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
            type = "macvtap";
            id = "dns-tap";
            mac = "ce:b3:a5:0c:94:f8";

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
            "10.123.0.50/24"
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

        # Specific

        environment.systemPackages = [
          pkgs.dig
        ];

        services.resolved.enable = false;

        networking.firewall = {
          allowedTCPPorts = [53];
          allowedUDPPorts = [53];
        };

        services.blocky = {
          enable = true;
          settings = {
            upstreams.groups.default = [
              "127.0.0.1:5335"
            ];
            customDNS = {
              customTTL = "1h";
              filterUnmappedTypes = true;
              mapping."storage.kotee.co" = "10.123.0.5,2001:9b1:4fe:4402:9837:2dff:fe73:95ef";
            };
            blocking = {
              denylists.ads = [
                "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
                "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
                "http://sysctl.org/cameleon/hosts"
                "https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt"
              ];
              clientGroupsBlock.default = ["ads"];
            };
          };
        };

        services.unbound = {
          enable = true;
          settings = {
            server = {
              # When only using Unbound as DNS, make sure to replace 127.0.0.1 with your ip address
              # When using Unbound in combination with pi-hole or Adguard, leave 127.0.0.1, and point Adguard to 127.0.0.1:PORT
              interface = ["127.0.0.1" "::1"];
              port = 5335;
              access-control = ["127.0.0.1 allow"];
              # Based on recommended settings in https://docs.pi-hole.net/guides/dns/unbound/#configure-unbound
              harden-glue = true;
              harden-dnssec-stripped = true;
              use-caps-for-id = false;
              prefetch = true;
              edns-buffer-size = 1232;

              module-config = "\"dns64 validator iterator\"";
              dns64-prefix = "64:ff9b::/96";

              # Custom settings
              hide-identity = true;
              hide-version = true;
            };
            forward-zone = [
              # Example config with quad9
              {
                name = ".";
                forward-addr = [
                  "9.9.9.9#dns.quad9.net"
                  "149.112.112.112#dns.quad9.net"
                ];
                forward-tls-upstream = true; # Protected DNS
              }
            ];
          };
        };
      };
    };
  };
}
