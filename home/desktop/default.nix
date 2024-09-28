{pkgs, ...}: {
  imports = [
    ./niri.nix
    ./waybar.nix
    ./swaybg.nix
    ./xwayland-session.nix
  ];

  home.packages = with pkgs; [
    ncpamixer
    brightnessctl
    wl-clipboard
    wayland-utils
    cage
  ];
}
