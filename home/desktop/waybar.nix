{
  pkgs,
  config,
  ...
}: let
  lib = pkgs.lib;

  colorNames = [
    "base00"
    "base01"
    "base02"
    "base03"
    "base04"
    "base05"
    "base06"
    "base07"
    "base08"
    "base09"
    "base0A"
    "base0B"
    "base0C"
    "base0D"
    "base0E"
    "base0F"
  ];

  # Colors used in the markup
  colors = config.lib.stylix.colors.withHashtag;
  defineColor = name: value: "@define-color ${name} ${value};";
in {
  stylix.targets.waybar.enable = false;

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

      spacing = 0;

      modules-left = ["clock#hour" "clock#minute" "niri/workspaces"];
      modules-center = [];
      modules-right = ["tray" "network" "battery"];

      battery = {
        format = "{icon}";
        format-icons = ["" "" "" "" ""];
        tooltip-format = "{capacity}% {power:.1f}W ({timeTo})";
      };
      "clock#hour".format = "{:%H}";
      "clock#minute".format = "{:%M}";

      network = {
        interface = "wlo1";
        format = "󰤫";
        format-wifi = "{icon}";
        format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        format-disconnected = "󰤫";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        tooltip-format-disconnected = "Disconnected";
      };

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "";
          default = "";
        };
      };
    };
    style =
      lib.strings.concatStringsSep "\n"
      (
        # Convert the colors attribute set to GTK color declarations
        builtins.map (color: defineColor color colors.${color}) colorNames
      )
      +
      # Append the main CSS file
      (builtins.readFile ./waybar.css)
      +
      # Use monospace font
      ''
        /* Font family injected by Nix */
        * {
          font-family: ${config.stylix.fonts.monospace.name};
        }
      '';
  };
}
