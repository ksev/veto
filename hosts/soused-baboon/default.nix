# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
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
    nerd-fonts.jetbrains-mono
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
  boot.loader.timeout = 0;

  # programs.regreet.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  environment.gnome.excludePackages = [
    pkgs.baobab
    pkgs.epiphany
    pkgs.geary
    pkgs.gnome-text-editor
    pkgs.gnome-calendar
    pkgs.gnome-characters
    pkgs.gnome-clocks
    pkgs.gnome-contacts
    pkgs.gnome-font-viewer
    pkgs.gnome-logs
    pkgs.gnome-maps
    pkgs.gnome-music
    pkgs.gnome-weather
    pkgs.gnome-connections
    pkgs.simple-scan
    pkgs.snapshot
    pkgs.totem
    pkgs.yelp
  ];

  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = with pkgs; lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
    # Plugins to reuse ffmpeg to play almost every video format
    gst_all_1.gst-libav
    # Support the Video Audio (Hardware) Acceleration API
    gst_all_1.gstreamer
    # Common plugins like "filesrc" to combine within e.g. gst-launch
    gst_all_1.gst-plugins-base
    # Specialized plugins separated by quality
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];

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

  networking.wireguard.enable = true;
  networking.firewall.enable = false;
  networking.hostName = "soused-baboon"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  powerManagement.enable = true;
  programs.firefox.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["kim"];
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
      custom = {
        start = ''
          ${pkgs.libnotify}/bin/notify-send "GameMode started"; localsearch daemon --miner 'org.freedesktop.Tracker3.Miner.Files' --pause GameMode
        '';
        end = ''
          ${pkgs.libnotify}/bin/notify-send "GameMode ended"; localsearch daemon --miner 'org.freedesktop.Tracker3.Miner.Files' --resume 1
        '';
      };
    };
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

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
  hardware.xone.enable = true;
  services.fwupd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.kim = {
    isNormalUser = true;
    hashedPassword = "$7$CU..../....Zgid.HbvcW6RfhCavldJY/$8isjd.460mNAnrrYIcLfTDEAEjeWRkruopvQteBXgz9";
    extraGroups = ["wheel" "networkmanager" "gamemode" "dialout"]; # Enable ‘sudo’ for the user.
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

  system.stateVersion = "24.05"; # Did you read the comment?
}
