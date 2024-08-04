{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = {
      language-server.nixd = {
        command = "nixd";
        args = ["--log" "error"];
      };

      /*
      language-server.roslyn-ls = {
        command = "Microsoft.CodeAnalysis.LanguageServer";
        args = ["--logLevel" "Error" "--extensionLogDirectory" "/tmp/"];
      };
      */

      language = [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter = {
            command = "alejandra";
            args = ["--quiet"];
          };
        }
        /*
        {
          name = "c-sharp";
          language-servers = ["roslyn-ls"];
        }
        */
      ];
    };
  };

  home.packages = with pkgs; [
    # Add nix language server for helix globally
    nixd
    alejandra
  ];
}
