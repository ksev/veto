{pkgs, ...}: {
  servicevm.dns = {
    ip = "10.123.0.50";
    mac = "ce:b3:a5:0c:94:f8";

    config = {
      environment.systemPackages = [
        pkgs.dig
      ];

      services.resolved.enable = false;

      networking.firewall = {
        allowedTCPPorts = [53];
        allowedUDPPorts = [53];
      };

      systemd.services.blocky.after = ["unbound.service"];

      services.blocky = {
        enable = true;
        settings = {
          upstreams.groups.default = [
            "127.0.0.1:5335"
          ];
          bootstrapDns = [
            "127.0.0.1:5335"
          ];
          customDNS = {
            customTTL = "1h";
            filterUnmappedTypes = true;
            mapping = {
              "storage.kotee.co" = "10.123.0.5,2001:9b1:4fe:4402:9837:2dff:fe73:95ef";
              "prowlarr.kotee.co" = "10.123.0.10,2001:9b1:4fe:4402:7842:e6ff:feb5:e450";
              "radarr.kotee.co" = "10.123.0.10,2001:9b1:4fe:4402:7842:e6ff:feb5:e450";
              "sonarr.kotee.co" = "10.123.0.10,2001:9b1:4fe:4402:7842:e6ff:feb5:e450";
              "rlib.kotee.co" = "10.123.0.15,2001:9b1:4fe:4402:1044:37ff:feea:c61f";
            };
          };
          blocking = {
            denylists.ads = [
              "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
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
        };
      };
    };
  };
}
