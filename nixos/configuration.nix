# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.kernelParams = ["quiet"];

  # Define your hostname.
  networking.hostName = "mope-nixos"; 

  # Enable networking.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable zram swap.
  zramSwap.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap.
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];
  services.printing.browsing = true;
  services.printing.browsedConf = ''
    BrowseDNSSDSubTypes _cups,_print
    BrowseLocalProtocols all
    BrowseRemoteProtocols all
    CreateIPPPrinterQueues All
    BrowseProtocols all
  '';

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pedro = {
    isNormalUser = true;
    description = "Pedro Henrique Quitete Barreto";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "vboxusers" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install programs.
  programs = {

    # Internet
    firefox.enable = true;
    firefox.languagePacks = [ "pt-BR" ];
    thunderbird.enable = true;

    # Office
    evolution.enable = true;
    evolution.plugins = [ pkgs.evolution-ews ];
    system-config-printer.enable = true;
    java.enable = true;

    # CLI Tools
    vim.enable = true;
    git.enable = true;

    # GUI tools
    corectrl.enable = true;

    # Games
    gamescope.enable = true;
    gamemode.enable = true;
    steam.enable = true;

    # Audio/Video
    obs-studio.enable = true;

    # Virtualization
    virt-manager.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Internet
    polari
    fractal
    nicotine-plus
    qbittorrent
    discord
    shortwave
    signal-desktop
    telegram-desktop
    brave
    ferdium
    insync
    microsoft-edge
    spotify
    zoom-us
    ungoogled-chromium

    # Games
    dolphin-emu
    dosbox-staging
    retroarch
    lutris
    superTux
    superTuxKart
    xonotic
    extremetuxracer
    heroic
    protonup-qt
    mame

    # Audio/Video
    audacious
    audacity
    kdePackages.kdenlive
    lmms
    vlc

    # CLI tools
    fastfetch
    beep
    wget
    distrobox
    podman
    fortune
    graphicsmagick
    rclone
    rsync
    stress-ng
    tesseract
    unrar
    yt-dlp
    ocrmypdf
    rmlint
    speedtest-cli
    ventoy

    # GUI tools
    gparted
    keepassxc
    mangohud
    goverlay
    qpwgraph
    cpu-x
    bottles
    kdePackages.k3b

    # Education
    bibletime

    # Office
    diffpdf
    gimp
    inkscape
    kdePackages.kolourpaint
    krita
    libreoffice
    papers
    pdfarranger
    pdfmixtool
    pdfslicer
    joplin-desktop
    onlyoffice-desktopeditors
    pdfsam-basic
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US
    
    # Virtualization/Emulation
    _86Box-with-roms

    # Gnome extensions
    gnomeExtensions.weather-oclock
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
  ];

  # Install fonts.
  fonts.packages = with pkgs; [
    vistafonts
  ];

  # List services that you want to enable:
  services = {
  
    # Enable flatpak
    flatpak.enable = true;
  
    # Enable pcsc-lite
    pcscd.enable = true;
    pcscd.plugins = [ pkgs.ccid ];

    # Enable fwupd
    fwupd.enable = true;
  
    # Enable avahi
    avahi.enable = true;
    avahi.nssmdns4 = true;
  };

  # Enable virtualization.
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;  
    virtualbox.host.enable = true;
  };

# This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
