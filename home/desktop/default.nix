{pkgs, ...}: {
  imports = [
    ./niri.nix
    ./waybar.nix
    ./swaybg.nix
    ./xwayland-session.nix
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
        ];
      };
      "org/gnome/mutter" = {
        experimental-features = [
          "scale-monitor-framebuffer"
          "variable-refresh-rate"
        ];
      };
    };
  };

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
    nautilus
    helvum
    networkmanagerapplet

    dbeaver-bin
    gnome-tweaks

    gnomeExtensions.blur-my-shell
  ];
}
