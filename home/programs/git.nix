{pkgs, ...}: let
  name = "Kim Sevandersson";
  email = "kim@kotee.co";
in {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    ignores = [
      ".envrc"
      ".direnv"
      ".jj"
    ];
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };

  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    lazyjj
  ];

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
