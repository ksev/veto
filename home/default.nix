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

  home.packages = with pkgs; [
    _1password
  ];

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentitiesOnly=yes
        IdentityAgent ${onePassPath}
    '';
  };

  imports = [
    ./shell
    ./programs
  ];
}
