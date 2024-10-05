{lib, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dynamic_padding = true;
        opacity = lib.mkForce 0.98;
        blur = true;
      };
    };
  };
}
