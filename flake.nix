{
  description = "Declare the world, veto hysteresis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
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
