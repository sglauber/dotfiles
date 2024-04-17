{ pkgs, ... }: {
	users.users.lonen = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [
			"audio"
			"networkmanager"
			"video"
			"wheel"
		];
        packages = with pkgs; [ firefox git neovim kitty ripgrep wl-clipboard ];
	};
}
