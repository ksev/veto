{ config, pkgs, ... }:
{
  imports = [
    ./nushell
    ./bash.nix
  ];

  # Env
  home.sessionVariables = { };
}
