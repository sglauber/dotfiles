_: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      keymaps = {
        # Find files using Telescope command-line sugar.
        "<leader>sf" = "find_files";
        "<leader>sh" = "help_tags";
        "<leader>sg" = "git_files";
        "<leader>sd" = "diagnostics";
        "<leader><leader>" = "buffers";

        # FZF like bindings
        #"<C-p>" = "git_files";
        "<leader>s." = "oldfiles";
        "<leader>s/" = "live_grep";
      };

      settings.defaults = {
        file_ignore_patterns = [
          "^.git/"
        ];
        set_env.COLORTERM = "truecolor";
      };
    };
  };
}
