{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
    home.package = with pkgs; [
      gnome-tweaks
      gnomeExtensions.blur-my-shell
      gnomeExtensions.grand-theft-focus
      gnomeExtensions.no-overview
      gnomeExtensions.vitals
    ];

    gtk.iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

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
  };
}
