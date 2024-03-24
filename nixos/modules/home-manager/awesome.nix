{inputs, outputs, pkgs, ...}:

# how to get the value of user from variablees ?
{
  xdg.configFile."/home/lonen/.config/awesome/" = {
    source = ./awesome;
    recursive = true;
  };
}
