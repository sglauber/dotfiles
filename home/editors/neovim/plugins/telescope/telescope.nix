_: {
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        fzf-native.enable = true;
      };

      keymaps = {
        "<leader>sf" = {
          action = "find_files";
          options.desc = "[S]earch Project [F]iles";
        };

        "<leader>sh" = {
          action = "help_tags";
          options.desc = "[S]earch [H]elp Pages";
        };

        "<leader>sD" = {
          action = "diagnostics";
          options.desc = "[S]earch Workspace [D]iagnostics";
        };

        "<leader>sb" = {
          action = "buffers";
          options.desc = "[S]earch [B]uffers";
        };

        "<leader>sg" = {
          action = "git_files";
          options.desc = "[S]earch [G]it Project Files";
        };

        "<leader>s." = {
          action = "oldfiles";
          options.desc = "[S]earch Recent Files";
        };

        "<leader>s/" = {
          action = "live_grep";
          options.desc = "Grep (root dir)";
        };
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
