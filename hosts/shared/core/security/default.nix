_: {
  # environment.shellAliases.sudo = "doas";

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };

    doas = {
      enable = false;
      wheelNeedsPassword = false;
    };

    # Allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";

    # Needed for wayland
    polkit.enable = true;
  };
}
