{pkgs, ...}: {
  imports = [
    ./gnome.nix
    ./mangohud.nix
    #./niri
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
    helvum
    networkmanagerapplet

    bottles

    google-chrome
    postman
    slack
    filezilla
    dbeaver-bin
    zed-editor
  ];
}
