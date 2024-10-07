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
    wl-clipboard-x11
    wayland-utils
    nautilus
    cage
    helvum
    cabextract
    eww

    dbeaver-bin
  ];
}
