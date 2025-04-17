{config, ...}: {
  servicevm.arr = {
    ip = "10.123.0.10";
    mac = "7a:42:e6:b5:e4:50";
    config = {
      microvm = {
        vcpu = 4;
        mem = 4096;
        volumes = [
          {
            label = "lib";
            image = "lib";
            mountPoint = "/var/lib";
            size = 1024;
            autoCreate = true;
          }
        ];
        shares = [
          {
            tag = "media";
            proto = "virtiofs";
            securityModel = "mapped";
            source = "/storage/Media";
            mountPoint = "/media";
          }
          {
            tag = "downloads";
            proto = "virtiofs";
            securityModel = "mapped";
            source = "/storage/Downloads";
            mountPoint = "/downloads";
          }
        ];
      };

      users.groups.storage =
        config.users.groups.storage
        // {
          members = ["root" "kim" "sonarr" "radarr"];
        };

      networking.firewall = {
        allowedTCPPorts = [80 443];
        allowedUDPPorts = [80 443];
      };

      services.caddy = {
        enable = true;
        virtualHosts."prowlarr.kotee.co".extraConfig = ''
          reverse_proxy http://127.0.0.1:9696
        '';
        virtualHosts."sonarr.kotee.co".extraConfig = ''
          reverse_proxy http://127.0.0.1:9697
        '';
        virtualHosts."radarr.kotee.co".extraConfig = ''
          reverse_proxy http://127.0.0.1:9698
        '';
      };

      services.sabnzbd = {
        enable = true;
        group = "storage";
      };

      services.prowlarr = {
        enable = true;
        settings = {
          update.mechanism = "external";
          server = {
            port = 9696;
            bindaddress = "127.0.0.1";
          };
        };
      };

      services.sonarr = {
        enable = true;
        group = "storage";
        settings = {
          update.mechanism = "external";
          server = {
            port = 9697;
            bindaddress = "127.0.0.1";
          };
        };
      };

      services.radarr = {
        enable = true;
        group = "storage";
        settings = {
          update.mechanism = "external";
          server = {
            port = 9698;
            bindaddress = "127.0.0.1";
          };
        };
      };
    };
  };
}
