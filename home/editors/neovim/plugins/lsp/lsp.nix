_: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
        };

        servers = {
          clangd.enable = true;
          elixirls.enable = true;
          eslint.enable = true;
          lua-ls = {
            enable = true;
            extraOptions = {
              settings = {
                Lua = {
                  completion = {
                    callSnippet = "Replace";
                  };
                  hint.enable = true;
                  telemetry.enabled = false;
                };
              };
            };
          };
          gopls.enable = true;
          intelephense.enable = true;
          nil-ls.enable = true;
          yamlls.enable = true;
        };
      };
    };
  };
}
