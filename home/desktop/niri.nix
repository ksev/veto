{
  programs.niri.settings = {
    input = {
      keyboard.xkb.layout = "se";

      touchpad = {
        tap = true;
        natural-scroll = false;
      };

      warp-mouse-to-focus = false;
    };
    outputs."eDP-1" = {
      scale = 1.33;
      variable-refresh-rate = true;
    };
    window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = let
          r = 6.0;
        in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
      }
    ];
    layout = {
      gaps = 16;
      center-focused-column = "never";
      preset-column-widths = [
        { proportion = 1. / 3.; }
        { proportion = 1. / 2.; }
        { proportion = 2. / 3.; }
      ];
      default-column-width.proportion = 0.5;
      focus-ring = {
        width = 4;
      };
    };
    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = [];
      "Mod+T".action.spawn = "alacritty";
      "Mod+D".action.spawn = "fuzzel";
      "Mod+Q".action.close-window = [];
      
      "Mod+Shift+E".action.quit = [];
      "Mod+Left".action.focus-column-left = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+Up".action.focus-window-up = [];
      "Mod+Down".action.focus-window-down = [];

      "Mod+Ctrl+Left".action.move-column-left = [];
      "Mod+Ctrl+Right".action.move-column-right = [];
      "Mod+Ctrl+Up".action.move-window-up = [];
      "Mod+Ctrl+Down".action.move-window-down = [];

      "Mod+Home".action.focus-column-first = [];
      "Mod+End".action.focus-column-last = [];
      "Mod+Ctrl+Home".action.move-column-to-first = [];
      "Mod+Ctrl+End".action.move-column-to-last = [];

      "Mod+Comma".action.consume-window-into-column = [];
      "Mod+Period".action.expel-window-from-column = [];

      "Mod+R".action.switch-preset-column-width = [];
      "Mod+F".action.maximize-column = [];
      "Mod+Shift+F".action.fullscreen-window = [];
      "Mod+Ctrl+R".action.reset-window-height = [];
      "Mod+Minus".action.set-column-width = ["-10%"];
      "Mod+Plus".action.set-column-width = ["+10%"];
      
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "+10"];
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "10-"];
      "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_SINK@" "toggle"]; 
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "0.05-" "-l" "1.0"]; 
      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_SINK@" "0.05+" "-l" "1.0"]; 
    };
  };
}
