args @ {
  lib,
  config,
  pkgs,
  ...
}: let
    vms = [./dns.nix];
  commonVMConfig = name: mac: linkNr: more: lib.recursiveUpdate {
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
        inherit mac;
        type = "macvtap";
        id = "${name}-tap";

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
        "10.123.0.${toString linkNr}/24"
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
  } more;
in {
  imports = map (vm: import vm (args // {inherit commonVMConfig;})) vms;
}
