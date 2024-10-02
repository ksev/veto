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
    sofOverlay = final: prev: {
      sof-firmware = prev.sof-firmware.overrideAttrs (old: {
        version = "2024.09";
        src = pkgs.fetchurl {
          url = "https://github.com/thesofproject/sof-bin/releases/download/v2024.09/sof-bin-2024.09.tar.gz";
          sha256 = "sha256-6kfZn4E1kAjQdhi8oQPPePgthOlAv+lBoor+B8jLxiA=";
        };
      });
    };
  in {
    nixosConfigurations.tipsy-marmoset = nixpkgs.lib.nixosSystem {
      inherit pkgs system;

      modules = [
        niri.nixosModules.niri
        stylix.nixosModules.stylix
        ./hosts/tipsy-marmoset
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [niri.overlays.niri sofOverlay];
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kim = import ./home;
        }
      ];
    };
    homeConfigurations."kim" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home
        {
          vscode.enable = true;

          # Ostree dists mount home under /var
          home.homeDirectory = "/var/home/kim";
          targets.genericLinux.enable = true;
        }
      ];
    };
  };
}
