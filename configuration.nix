# ---------------------- #
# MY-NIXOS CONFIGURATION #
# ---------------------- #

# Configuration, library and more #
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Hardware #
      ./hardware-configuration.nix
    ];

  # Kernel #
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader #
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = false;

  # Network #
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone #
  time.timeZone = "Europe/Istanbul";

  # Proxy #
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Internationalisation #
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 #
  services.xserver.enable = true;

  # Desktop #
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  # Keymap X11 #
  services.xserver.xkb = {
    layout = "tr";
  };

  # Keymap in console #
  console.keyMap = "trq";

  # Printing #
  # services.printing.enable = true;

  # Packages managements #
  services.flatpak.enable = true;

  # Bluetooth #
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Sound #
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # media-session.enable = true;
  };

  # Touchpad #
  services.libinput.enable = true;

  # Cachix #
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # OpenGL #
  hardware.graphics = {
    enable = true;
  };

  # Wayland Electron #
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Shell #
  environment.shells = with pkgs; [ zsh bash ];
  environment.shellAliases = {
    nixrb = "sudo nixos-rebuild switch";
    nixconf = "sudo vim /etc/nixos/configuration.nix";
    nixup = "sudo nixos-rebuild switch --upgrade";
    nixclean = "sudo nix-collect-garbage -d";
  };
  programs.zsh.enable = true;

  # User account #
  users.users.hasan = {
    isNormalUser = true;
    description = "Hasan";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "flatpak" ];
    packages = with pkgs; [
    ];
    shell = pkgs.zsh;
  };

  # Unfree packages #
  nixpkgs.config.allowUnfree = true;

  # Browser #
  programs.firefox.enable = true;

  # Text editor #
  programs.vim.enable = true;

  # Vim configuration #
  environment.variables = {
    EDITOR = "vim";
  };

  # Gnome #
  environment.gnome.excludePackages = with pkgs; [
    atomix
    baobab
    epiphany
    evince
    geary
    gnome-backgrounds
    gnome-boxes
    gnome-clocks
    gnome-connections
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-software
    gnome-system-monitor
    gnome-text-editor
    gnome-tour
    gnome-weather
    hitori
    iagno
    simple-scan
    tali
    yelp
  ];

  # All packages #
  environment.systemPackages = with pkgs; [
    # Tuis #
    alsa-utils
    btop
    curl
    eza
    emacsPackages.mpv
    fastfetch
    fzf
    gcc_multi
    git
    jq
    libgcc
    nitch
    nix-search-cli
    nix-zsh-completions
    oh-my-zsh
    python314
    starship
    vim
    wget
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-z
    zoxide

    # Apps #
    bottles
    discord
    gimp
    libreoffice-qt6-fresh
    librecad
    lutris
    gnome-tweaks
    steam
    thunderbird

    # Fonts #
    nerd-fonts.caskaydia-mono
  ];

  # SUID #
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # OpenSSH #
  # services.openssh.enable = true;

  # Firewall #
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  # System version #
  system.stateVersion = "25.11";
}
