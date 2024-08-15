{
  programs.nushell = {
    enable = true;
    envFile.source = ./env.nu;
    configFile.source = ./config.nu;
    extraConfig = ''
      $env.config.hooks.env_change.PWD = (
        $env.config.hooks.env_change.PWD | append (source ${./flake_hook.nu})
      )
    '';
  };
}
