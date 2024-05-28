{
  pkgs,
  config,
  lib,
  ...
}: {
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [""];
    enableExtraSocket = true;
    pinentryPackage =
      if config.gtk.enable
      then pkgs.pinentry-gnome3
      else pkgs.pinentry-tty;
  };

  home.packages = lib.optional config.gtk.enable pkgs.gcr;

  programs = let
    fixGpg =
      /*
      bash
      */
      ''
        gpgconf --launch gpg-agent
      '';
  in {
    # Start gpg-agent if it's not running or tunneled in
    bash.profileExtra = fixGpg;
    zsh.loginExtra = fixGpg;

    gpg = {
      enable = true;
      settings = {
        trust-model = "tofu+pgp";
      };
      # publicKeys = [{trust = 5;}];
    };
  };

  systemd.user.services = {
    # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    # So that SSH config does not have to know the UID
    link-gnupg-sockets = {
      Unit = {
        Description = "link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
# vim: filetype=nix

