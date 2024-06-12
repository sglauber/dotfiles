{inputs, ...}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    secrets = {
      "private_keys/glwbr" = {
        path = "home/glwbr/.ssh/id_demo";
      };
    };
  };
}
