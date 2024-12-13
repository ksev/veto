{pkgs, ...}: let libs = (pkgs.runCommand "nu-libs" {} ''
  mkdir $out;
  cp ${./task.nu} $out/task.nu
''); in{
  services.pueue.enable = true;

  programs.nushell = {
    enable = true;
    envFile.source = ./env.nu;
    configFile.source = ./config.nu;
    extraConfig = ''
      use task.nu
    '';
    extraEnv = ''
      $env.NU_LIB_DIRS = $env.NU_LIB_DIRS | prepend ${libs}
    '';
  };
}
