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

  home.packages = with pkgs; [
    # For jj
    watchman
  ];

  programs.jujutsu = {
    enable = true;
    settings = {
      core = {
        fsmonitor = "watchman";
        watchman.register_snapshot_trigger = true;
      };
      user = {
        name = name;
        email = email;
      };
      ui = {
        default-command = "log";
        diff.tool = ["${pkgs.difftastic}/bin/difft" "--color=always" "$left" "$right"];
      };
    };
  };
}
