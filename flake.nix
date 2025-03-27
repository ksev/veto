{
  description = "Declare the world, veto hysteresis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    chaotic,
    disko,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    desktopSystem = path:
      nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          niri.nixosModules.niri
          stylix.nixosModules.stylix
          chaotic.nixosModules.default

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kim = import ./home;
          }

          path
        ];
      };
  in {
    nixosConfigurations = {
      tipsy-marmoset = desktopSystem ./hosts/tipsy-marmoset;
      soused-baboon = desktopSystem ./hosts/soused-baboon;
      wrecked-mandrill = nixpkgs.lib.nixosSystem {
        inherit pkgs system;

        modules = [
          disko.nixosModules.disko
          ./hosts/wrecked-mandrill
        ];
      };
    };
  };
}
