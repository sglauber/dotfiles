_: {
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--colors=line:style:bold"
      "--max-columns-preview"
      "--smart-case"
    ];
  };
}
