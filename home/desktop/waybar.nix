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
  systemd.user.services.waybar = {
    Unit = {
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings.mainBar = {
      layer = "top";
      position = "top";
      output = [
        "eDP-1"
        "HDMI-A-1"
      ];

      spacing = 0;

      modules-left = ["niri/workspaces" "niri/window"];
      modules-center = ["clock"];
      modules-right = ["battery" "tray"];

      "tray" = {
        "icon-size" = 18;
        "spacing" = 10;
      };

      battery = {
        format = "{icon} {capacity}%";
        format-icons = ["" "" "" "" ""];
        tooltip-format = "{timeTo} ({power:.1f}W)";
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
