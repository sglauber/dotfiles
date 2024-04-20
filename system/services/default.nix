_: {
  imports = [
    ./avahi.nix
    ./backlight.nix
    ./gnome-services.nix
    ./greetd.nix
    ./pipewire.nix
    ./power.nix
  ];

  services = {
    dbus.implementation = "broker";

    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };
}
