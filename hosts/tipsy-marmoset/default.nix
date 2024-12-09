{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  stylix.enable = true;
  stylix.autoEnable = false;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.image = ./wallpaper.jpg;

  stylix.cursor.package = pkgs.simp1e-cursors;
  stylix.cursor.name = "Simp1e-Dark";
  stylix.cursor.size = 24;

  fonts.packages = with pkgs; [
    dejavu_fonts
    roboto
    font-awesome
    nerd-fonts.symbols-only
  ];

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["bcachefs"];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot.plymouth.enable = true;
  # boot.consoleLogLevel = 0;
  # boot.initrd.verbose = false;
  # boot.initrd.systemd.enable = true;
  # boot.kernelParams = [
  # "quiet"
  # "splash"
  # "boot.shell_on_fail"
  #"loglevel=3"

  #"rd.systemd.show_status=false"
  #"rd.udev.log_level=3"
  #"udev.log_priority=3"
  # ];
  boot.loader.timeout = 0;

  # programs.regreet.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  nix = {
    gc.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  networking.hostName = "tipsy-marmoset"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  powerManagement.enable = true;

  /*
  services.tlp = {
    enable = true;
    settings = {
      RESTORE_THRESHOLDS_ON_BAT = 1;
      START_CHARGE_THRESH_BAT0 = 75; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 81; # 80 and above it stops charging    };
    };
  };
  */

  /*
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        enable_threshold = 20;
        stop_threshold = 80;
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  */

  services.upower.enable = true;
  programs.firefox.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["kim"];
  };

  programs.steam.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "nodeadkeys";
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.fwupd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kim = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    s0ix-selftest-tool
    pciutils
    acpica-tools
    powertop
    config.boot.kernelPackages.cpupower
    usbutils
  ];

  programs.niri.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
