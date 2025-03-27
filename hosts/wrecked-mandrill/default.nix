{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./partition.nix
    ./storage
    ./network.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.trusted-users = ["root" "kim"];

  users.mutableUsers = false;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users.kim = {
    isNormalUser = true;
    home = "/home/kim";
    extraGroups = ["wheel" "sudoers"];
    hashedPassword = "$7$CU..../....XFqWvUtW6Hml7XTlloZ.S/$zKQB.uWeZ8yek18H2pNpT0po80jayUQ5dwBP89ibe.6";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMXTCm7EwLcGpmqys3uvcQt72ZxbRc2fR4SJANtleFli"];
  };

  security.sudo.extraRules = [
    # We disable root access after provisioning to make sure we cant do it twice
    # So we need to be able to deploy new generations to the machines
    {
      users = ["kim"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  time.timeZone = "Europe/Stockholm";

  system.stateVersion = "24.11";
}
