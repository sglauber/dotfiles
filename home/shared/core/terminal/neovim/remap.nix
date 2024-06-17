{
  config,
  lib,
  ...
}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      # Normal mode key mappings
      normal =
        lib.mapAttrsToList (key: action: {
          mode = "n";
          inherit action key;
        })
        {
          # Movement modifications with Alt key
          "<M-k>" = ":move-2<CR>";
          "<M-j>" = ":move+<CR>";

          # Project view
          "<leader>pv" = "<cmd>Ex<CR>";

          # Search and replace the word under cursor
          "<leader>s" = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";

          # Movement reminders
          "<left>" = ''<cmd>echo "Use h to move!!"<CR>'';
          "<right>" = ''<cmd>echo "Use l to move!!"<CR>'';
          "<up>" = ''<cmd>echo "Use k to move!!"<CR>"'';
          "<down>" = ''<cmd>echo "Use j to move!!"<CR>"'';

          # Center the view on next and previous searches
          "<n>" = "nzzzv";
          "<N>" = "Nzzzv";

          # Clipboard operations
          "<leader>y" = "\"+y";
          "<leader>Y" = "\"+Y";

          # Delete without yanking
          "<leader>d" = "\"_d";

          # Make the current file executable
          "<leader>x" = "<cmd>!chmod +x %<CR>";

          # Disable the Q shortcut
          "Q" = "<nop>";
        };

      # Visual mode key mappings
      visual =
        lib.mapAttrsToList (key: action: {
          mode = "v";
          inherit action key;
        })
        {
          # Indenting operations
          ">" = ">gv";
          "<" = "<gv";
          "<TAB>" = ">gv";
          "<S-TAB>" = "<gv";

          # Clipboard operations in visual mode
          "<leader>y" = "\"+y";
          "<leader>p" = "\"_dP";

          # Move selected lines up and down
          "K" = ":m '<-2<CR>gv=gv";
          "J" = ":m '>+1<CR>gv=gv";
        };
    in
      config.nixvim.helpers.keymaps.mkKeymaps
      {options.silent = true;}
      (normal ++ visual);
  };
}
