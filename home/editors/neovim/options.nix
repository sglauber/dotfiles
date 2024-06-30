_: {
  programs.nixvim = {
    globals = {
      # Disable useless providers
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
      loaded_ruby_provider = 0; # Ruby
    };

    clipboard = {
      providers.wl-copy.enable = true;
    };

    opts = {
      # Colors
      termguicolors = true;

      # Cursor and scrolling
      colorcolumn = "120";
      cursorcolumn = false;
      cursorline = false;
      scrolloff = 8;
      signcolumn = "yes";

      # File management
      backup = false;
      fileencoding = "utf-8";
      swapfile = false;
      undofile = true;

      # Folding
      foldcolumn = "0";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;

      # Indentation
      autoindent = true;
      expandtab = true;
      shiftwidth = 4;
      softtabstop = 4;
      tabstop = 4;

      # Line numbers
      number = true;
      relativenumber = true;

      # Modeline
      modeline = true;
      modelines = 100;

      # Mouse control
      mouse = "a";
      mousemodel = "extend";

      # Performance settings
      updatetime = 50; # faster completion (4000ms default)

      # Search settings
      ignorecase = true;
      inccommand = "split"; # Search and replace: preview changes in quickfix list
      incsearch = true;
      smartcase = true;

      # Spell checking
      spell = false;

      # Split settings
      splitbelow = true;
      splitright = true;

      # Status line
      laststatus = 3;
      showmode = false;
      cmdheight = 0;

      # Text width
      textwidth = 0;

      # Text wrapping
      wrap = false;
    };
  };
}
