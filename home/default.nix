{
  lib,
  pkgs,
  ...
}: let
  onePassPath = "~/.1password/agent.sock";
in {
  home.username = "kim";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.homeDirectory = lib.mkDefault "/home/kim";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fuzzel.enable = true;
  gtk.iconTheme = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "None";
    };
  };

  services.mako = {
    enable = true;
  };

  programs.btop.enable = true;

  home.packages = with pkgs; [
    jetbrains.rider
    nh
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent ${onePassPath}
    '';
  };

  xdg.configFile."1Password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Personal"
    [[ssh-keys]]
    vault = "Pixlr"
    [[ssh-keys]]
    vault = "Homeserver"
    [[ssh-keys]]
    vault = "Biluppgifter"
    [[ssh-keys]]
    vault = "Cluster"
  '';

  imports = [
    ./shell
    ./programs
    ./desktop
  ];
}
