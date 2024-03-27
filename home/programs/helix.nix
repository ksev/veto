{ pkgs, ... }: 

{
	programs.helix.enable = true;
  programs.helix.defaultEditor = true;

	home.packages = with pkgs; [
		# Add nix language server for helix globally
		nil
	];
}
