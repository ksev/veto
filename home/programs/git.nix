{...}: let
  name = "Kim Sevandersson";
  email = "kim@kotee.co";
in {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
  };

  programs.lazygit.enable = true;

  programs.jujutsu.enable = true;
  programs.jujutsu.settings = {
    enable = true;
    user = {
      name = name;
      email = email;
    };
  };
}
