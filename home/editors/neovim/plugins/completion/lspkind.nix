_: {
  programs.nixvim = {
    plugins = {
      lspkind = {
        enable = true;

        symbolMap = {
          Copilot = "";
          Text = "󰊄";
          Method = "";
          Function = "󰡱";
          Constructor = "";
          Field = "";
          Variable = "󱀍";
          Class = "";
          Interface = "";
          Module = "󰕳";
          Property = "";
          Unit = "";
          Value = "";
          Enum = "";
          Keyword = "";
          Snippet = "";
          Color = "";
          File = "";
          Reference = "";
          Folder = "";
          EnumMember = "";
          Constant = "";
          Struct = "";
          Event = "";
          Operator = "";
          TypeParameter = "";
        };

        extraOptions = {
          maxwidth = 50;
          ellipsis_char = "...";
        };

        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
          };
        };
      };
    };
  };
}
