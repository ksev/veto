{
  description = "Declare the world, veto hysteresis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    niri,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    linux-firmware-git = final: prev: {
      linux-firmware = prev.linux-firmware.overrideAttrs (old: {
        version = "20250305";

        src = pkgs.fetchgit {
          url = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git";
          rev = "44740031a34e61a47162f94961e3155c8c8470e2";
          sha256 = "sha256-SfjM+FgF8DMPUQGIK2EzWU7Cs8sdAFl0Mi1Q+OVRhto=";
        };
      });
    };
    desktopSystem = path:
      nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          niri.nixosModules.niri
          stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager

          {
            nixpkgs.overlays = [linux-firmware-git];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kim = import ./home;
          }

          path
        ];
      };
  in {
    nixosConfigurations.tipsy-marmoset = desktopSystem ./hosts/tipsy-marmoset;
    nixosConfigurations.soused-baboon = desktopSystem ./hosts/soused-baboon;
  };
}
