_: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<C-p>" = "goto_prev";
            "<C-n>" = "goto_next";
            "<C-y>" = "confirm";
            "<C-space>" = "complete";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };

        servers = {
          clangd.enable = true;
          lua-ls.enable = true;
        };
      };
    };
  };
}
