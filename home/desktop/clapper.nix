{pkgs, lib, ...}: {
  # Clapper video package with gstreamer plugins
  home.packages = with pkgs; [
    clapper
  ];
}
