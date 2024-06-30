_: {
  programs.nixvim = {
    plugins = {
      lint = {
        enable = true;
        lintersByFt = {
          nix = ["statix"];
          lua = ["selene"];
          javascript = ["eslint_d"];
          javascriptreact = ["eslint_d"];
          typescript = ["eslint_d"];
          typescriptreact = ["eslint_d"];
          json = ["jsonlint"];
        };
      };
    };
  };
}
