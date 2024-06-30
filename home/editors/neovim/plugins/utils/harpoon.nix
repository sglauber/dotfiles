_: {
  programs.nixvim = {
    plugins = {
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymapsSilent = true;
        keymaps = {
          addFile = "<leader>a";
          toggleQuickMenu = "<C-e>";
          navFile = {
            "1" = "<C-1>";
            "2" = "<C-2>";
            "3" = "<C-3>";
            "4" = "<C-4>";
          };
        };
      };
    };
  };
}
