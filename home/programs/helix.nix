{pkgs, ...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    /*
    languages = {
      language-server.roslyn-ls = {
        command = "Microsoft.CodeAnalysis.LanguageServer";
        args = ["--logLevel" "Error" "--extensionLogDirectory" "/tmp/"];
      };

      language = [
        {
          name = "c-sharp";
          language-servers = ["roslyn-ls"];
        }
      ];
    };
    */
  };

  home.packages = with pkgs; [
    # Add nix language server for helix globally
    nixd
    alejandra
  ];
}
