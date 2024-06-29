_: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        folding = true;
        indent = true;
        nixvimInjections = true;
      };

      treesitter-refactor = {
        enable = true;
        highlightDefinitions = {
          enable = true;
          # Set to false if `updatetime` of ~100.
          clearOnCursorMove = false;
        };
      };

      hmts.enable = true;
    };
  };
}
