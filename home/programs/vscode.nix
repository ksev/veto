{ pkgs, lib, config, ... }: {
	options = {
		vscode.enable = lib.mkEnableOption "enable VisualStudio Code";
	};

	config = lib.mkIf config.vscode.enable {
			programs.vscode.enable = true;
			programs.vscode.enableUpdateCheck = false;
			programs.vscode.extensions = with pkgs.vscode-extensions; [
				ms-dotnettools.csharp
				ms-dotnettools.csdevkit
				rust-lang.rust-analyzer
			];
	};
}
