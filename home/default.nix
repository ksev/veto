{
  lib,
  pkgs,
  ...
}: let
  onePassPath = "~/.1password/agent.sock";
in {
  imports = [
    ./shell
    ./programs
    ./desktop
  ];

  home.username = "kim";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.homeDirectory = lib.mkDefault "/home/kim";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.btop.enable = true;

  home.packages = with pkgs; [
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
}
