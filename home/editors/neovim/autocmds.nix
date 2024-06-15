_: {
  programs.nixvim.autoCmd = [
    # Enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = [
        "markdown"
      ];
      command = "setlocal spell spelllang=en,pt-br";
    }
  ];
}
