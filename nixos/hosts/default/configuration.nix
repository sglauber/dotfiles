{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./user.nix
    inputs.home-manager.nixosModules.default
  ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = false;
  boot.loader = {
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
    };
    efi = {canTouchEfiVariables = true;};
  };

  networking = {
    # defining hostname
    hostName = "anchor";
    # enable networkManager
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1	idv.local
      127.0.0.1	idv2.local
      127.0.0.1	ticket.local
    '';
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set time zone.
  time.timeZone = "America/Bahia";

  # Select internationalisation properties.
  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.utf8";
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services = {
    xserver = {
      xkb.layout = "us";
      xkb.options = "eurosign:e,caps:escape";
      enable = true;
      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        sddm.enable = true;
        # defaultSession = "none+awesome";
        defaultSession = "hyprland";
      };

      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [luarocks luadbi lua cjson];
      };

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };
    # Enable sound.
    pipewire = {
      audio.enable = true;
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    openssh.enable = true;
    sshd.enable = true;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
    '';
    fstrim.enable = true;
  };

  # Something for sound idk
  security.rtkit.enable = true;
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.acpilight.enable = lib.mkDefault true;
  hardware.sensor.iio.enable = lib.mkDefault true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  main-user.enable = true;
  main-user.userName = "lonen";

  # home-manager = {
  #     extraSpecialArgs = { inherit inputs; };
  #     useUserPackages = true;
  #     useGlobalPkgs = true;
  #     users = { "lonen" = import ./home.nix; };
  # };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "UbuntuMono" "SourceCodePro" "Iosevka" "IBMPlexMono" "Hack"];})
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    alacritty
    bat
    gawk
    eza
    fzf
    wezterm
    git
    git-lfs
    gnumake
    rofi
    ripgrep
    fd
    docker-compose
    pciutils
    nodejs
    unzip
    xclip
    maim
    wl-clipboard
    xclip
    luajitPackages.lua-lsp
    nil
  ];

  virtualisation.docker.enable = true;

  #   virtualisation.docker.rootless = { -- rootless docker ?
  #	   enable = true;
  #	   setSocketVariable = true;
  #   };

  # virtualisation.docker.storageDriver = "btrfs";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {
    hyprland = {enable = true;};
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
    };
    # Please nano leave me alone :(
    nano.enable = false;
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      luarocks
      lua
      cjson
    ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  zramSwap.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
