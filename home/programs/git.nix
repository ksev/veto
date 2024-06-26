{...}: let
  name = "Kim Sevandersson";
  email = "kim@kotee.co";
in {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };

  programs.lazygit.enable = true;

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = name;
        email = email;
      };
    };
  };
}
