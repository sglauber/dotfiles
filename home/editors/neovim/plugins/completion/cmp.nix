_: {
  programs.nixvim = {
    opts.completeopt = ["menu" "menuone" "noinsert"];

    plugins = {
      luasnip.enable = true;

      cmp = {
        enable = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            {name = "luasnip";}
            {name = "nvim_lsp";}
            {name = "path";}
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
          ];

          performance = {
            debounce = 60;
            fetching_timeout = 200;
            max_view_entries = 30;
          };

          window = {
            completion = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None";
            };
            documentation = {
              border = "rounded";
            };
          };
          formatting = {
            fields = ["kind" "abbr" "menu"];
            expandable_indicator = true;
          };
        };
      };
    };
  };
}
