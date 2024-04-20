_: {
  imports = [
    ./pipewire.nix
    ./greetd.nix
    ./avahi.nix
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
