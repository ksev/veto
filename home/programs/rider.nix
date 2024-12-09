{pkgs, ...}: {
  /*
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-7.0.410"
  ];
  */

  home.packages = with pkgs; [
    jetbrains.rider
  ];
}
