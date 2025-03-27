{
  networking = {
    hostId = "8b0d926f";
    hostName = "wrecked-mandrill";
    firewall.enable = false;
    useDHCP = false;
    # nftables.enable = true;
  };

  systemd.network.enable = true;
  systemd.network = {
    netdevs = {
      "10-bond0" = {
        netdevConfig = {
          Kind = "bond";
          Name = "bond0";
        };
        bondConfig = {
          Mode = "802.3ad";
          TransmitHashPolicy = "layer3+4";
        };
      };
      "20-iot" = {
        netdevConfig = {
          Kind = "vlan";
          Name = "iot";
        };
        vlanConfig.Id = 2;
      };
      "20-services" = {
        netdevConfig = {
          Kind = "vlan";
          Name = "services";
        };
        vlanConfig.Id = 3;
      };
    };
    networks = {
      "30-enp15s0" = {
        matchConfig.Name = "enp15s0";
        networkConfig.Bond = "bond0";
      };
      "30-enp15s0d1" = {
        matchConfig.Name = "enp15s0d1";
        networkConfig.Bond = "bond0";
      };
      "40-bond0" = {
        matchConfig.Name = "bond0";
        dns = ["10.121.0.1" "fe80::7845:58ff:fee4:3cfe"];
        vlan = [
          "iot"
          "services"
        ];
        networkConfig = {
          IPv6AcceptRA = true;
        };
        address = [
          "10.121.0.5/24"
        ];
        gateway = [
          "10.121.0.1"
        ];
      };
      "50-iot" = {
        matchConfig.Name = "iot";
        dns = ["10.122.0.1" "fe80::7a45:58ff:fee4:3d07"];
        networkConfig = {
          IPv6AcceptRA = true;
        };
        address = [
          "10.122.0.5/24"
        ];
        gateway = [
          "10.122.0.1"
        ];
      };
      "50-services" = {
        matchConfig.Name = "services";
        dns = ["10.123.0.1" "fe80::7a45:58ff:fee4:3d07"];
        networkConfig = {
          IPv6AcceptRA = true;
        };
        address = [
          "10.123.0.5/24"
        ];
        gateway = [
          "10.123.0.1"
        ];
      };
    };
  };
}
