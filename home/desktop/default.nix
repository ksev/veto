{pkgs, ...}: {
  imports = [
    ./gnome.nix
    ./niri.nix
    ./waybar.nix
    ./swaybg.nix
    ./xwayland-session.nix
  ];

  stylix.targets = {
    alacritty.enable = true;
    btop.enable = true;
    fuzzel.enable = true;
    helix.enable = true;
    k9s.enable = true;
    nushell.enable = true;
    niri.enable = true;
  };

  home.packages = with pkgs; [
    ncpamixer
    brightnessctl
    wl-clipboard
    wl-clipboard-x11
    wayland-utils
    helvum
    networkmanagerapplet

    dbeaver-bin
    zed-editor
  ];
}
