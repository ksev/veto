{...}: {
  programs.mangohud = {
    enable = true;
    # This adds mangohud to all GTK apps atm
    # enableSessionWide = true;

    settings = {
      toggle_preset = "F7";
      toggle_fps_limit = "F8";
      fps_limit = "118,238,0";
      pci_dev = "0000:03:00.0";
      # no_display = true;
    };
  };
}
