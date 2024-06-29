_: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          #diagnostic = {
          #  # Navigate in diagnostics
          #  "<C-p>" = "goto_prev";
          #  "<C-n>" = "goto_next";
          #  "<C-y>" = "confirm";
          #  "<C-space>" = "complete";
          #};

          #lspBuf = {
          #  K = "hover";
          #  gd = "definition";
          #  gD = "references";
          #  gi = "implementation";
          #  gt = "type_definition";
          #};
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
          nil-ls.enable = true;
          yamlls.enable = true;
        };
      };
    };
  };
}
