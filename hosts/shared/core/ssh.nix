{
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  # hosts = lib.attrNames outputs.nixosConfigurations;
  # Sops needs acess to the keys before the persist dirs are even mounted; so
  # just persisting the keys won't work, we must point at /persist
  # hasOptinPersistence = config.environment.persistence ? "/persist";
in {
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };

    # hostKeys = [{}];
  };

  # programs.ssh = {};

  # Keep SSH_AUTH_SOCK when sudo'ing
  # security.sudo.extraConfig = ''
  #   Defaults env_keep+=SSH_AUTH_SOCK
  # '';
}
