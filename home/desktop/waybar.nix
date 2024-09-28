{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "left";
      output = [
        "eDP-1"
        "HDMI-A-1"
      ];
      modules-left = ["niri/workspaces"];
      modules-center = [];
      modules-right = ["battery" "battery#bat2" "clock"];
      "battery#bat2" = {
        format = "{power:.1f}W";
      };
      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
        };
      };
    };
    style = ./waybar.css;
  };
}
