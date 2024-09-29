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
  in {
    nixosConfigurations.tipsy-marmoset = nixpkgs.lib.nixosSystem {
      inherit pkgs system;

      modules = [
        niri.nixosModules.niri
        stylix.nixosModules.stylix
        ./hosts/tipsy-marmoset
        home-manager.nixosModules.home-manager
        {
           nixpkgs.overlays = [ niri.overlays.niri ];
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
