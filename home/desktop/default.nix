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
    cage
    helvum
    eww-wayland

    dbeaver-bin
  ];
}
