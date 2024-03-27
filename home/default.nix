{lib, ...}: {
  home.username = "kim";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.homeDirectory = lib.mkDefault "/home/kim";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./shell
    ./programs
  ];
}
