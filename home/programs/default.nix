{pkgs, ...}: {
  imports = [
    ./git.nix
    ./vscode.nix
    ./helix.nix
    ./alacritty.nix
    ./rider.nix
  ];

  home.packages = with pkgs; [
    tidal-hifi
    discord
  ];
}
