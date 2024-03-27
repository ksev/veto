{ config, pkgs, ... }:
{
  programs.bash = {	
    enable = true;
		# Make sure we get all the profile stuff from nix then switch to nushell
    initExtra = "
if [[ ! $(ps T --no-header --format=comm | grep \"^nu$\") && -z $BASH_EXECUTION_STRING ]]; then
    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
    exec \"${pkgs.lib.getExe pkgs.nushell}\" \"$LOGIN_OPTION\"
fi
        ";
  };
}
