{...}: {
  programs.mangohud = {
    enable = true;
    # This adds mangohud to all GTK apps atm
    # enableSessionWide = true;

    settings = {
      fps_limit = "118,238,0";
      pci_dev = "0000:03:00.0";
      toggle_preset = "Shift_R+F10";
      toggle_fps_limit = "Shift_L+F1";
      preset = "1,3,4,0";
      # no_display = true;
    };
  };
}
