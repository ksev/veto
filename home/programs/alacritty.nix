{lib, ...}:{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
        dynamic_padding = true;
        opacity = lib.mkForce 0.98;
        # blur = true;
      };
    };
  };
}
