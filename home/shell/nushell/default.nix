{
  programs.nushell = {
    enable = true;
    envFile.source = ./env.nu;
    configFile.source = ./config.nu;
    extraEnv = ''
      $env.NU_LIB_DIRS = [ ${./task.nu} ]
    '';
  };
}
