{
  osConfig,
  lib,
  pkgs,
  ...
}: let extensions = with pkgs.gnomeExtensions; [
  blur-my-shell
  grand-theft-focus
  no-overview
  vitals
  tiling-shell
] ++ (if osConfig.networking.hostName == "tipsy-marmoset" then [
  battery-health-charging
] else []); in {
  config = lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {
    home.packages = extensions;

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = map (e: e.extensionUuid) extensions;
        };
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer"
            "variable-refresh-rate"
            # "xwayland-native-scaling"
          ];
        };
      };
    };
  };
}
