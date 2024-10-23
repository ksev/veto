{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {
    home.packages = with pkgs; [
      gnomeExtensions.blur-my-shell
      gnomeExtensions.grand-theft-focus
      gnomeExtensions.no-overview
      gnomeExtensions.vitals
      gnomeExtensions.battery-health-charging
    ];

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            blur-my-shell.extensionUuid
            grand-theft-focus.extensionUuid
            no-overview.extensionUuid
            launch-new-instance.extensionUuid
            vitals.extensionUuid
            battery-health-charging.extensionUuid
          ];
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
