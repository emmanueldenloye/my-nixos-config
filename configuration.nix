# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./xmonad.nix
      # ./home-manager-setup.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  # discord upgrade fix
  # nixpkgs.overlays = [(self: super: { discord = super.discord.overrideAttrs (_: { src = builtins.fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz"; });})];

  # nixpkgs.overlays = [
  #   (self: super: {
  #     signal-desktop = (super.callPackage ./updated-signal-desktop.nix {}).signal-desktop;
  #     docker = (super.callPackage ./updated-docker.nix {}).docker_20_10;
  #   })
  # ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     keyMap = "dvorak-programmer";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    xkbVariant = "dvp";
    # resources = {
    #   "Xcursor.size" = "48";
    # };
  };

  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [ "mydb" ];
  #   authentication = ''
  #     # TYPE DATABASE   USER  ADDRESS              METHOD
  #     local  all        all                        peer
  #   '';
  # };

  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
    opacityRules = [ "100:name *= 'xlock'" ];
  };
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.emmanuel = {
     isNormalUser = true;
     home = "/home/emmanuel";
     description = "Emmanuel Denloye-Ito";
     extraGroups = [ "wheel" "networkmanager" "audio" "docker" "video" ]; # Enable ‘sudo’ for the user.
   };

   # home-manager.users.emmanuel = {pkgs, ... }: {
   #   home.packages = [ ];
   #   home.stateVersion = "23.11";
   # };

  fonts.fonts = with pkgs; [
    source-code-pro
    fira-code
    fira-code-symbols
    font-awesome
  ];

  environment.variables.XCURSOR_SIZE = "32";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget 
    vim
    neovim
    firefox
    ranger
    emacs
    slack
    xmobar
    ripgrep
    chromium
    jq
    qutebrowser
    zathura
    alacritty
    dmenu
    git
    discord
    slock
    gnupg
    blueberry
    pinentry
    brave
    du-dust
    acpi
    source-code-pro
    gnome3.gnome-terminal
    xclip
    stack
    cabal-install
    signal-desktop
    pkgs.haskellPackages.ghcid
    pkgs.haskellPackages.hlint
    pkgs.haskellPackages.hasktags
    tdesktop
    steam
    gnome3.cheese
    vlc
    ffmpeg
    octave
    feh
    scrot
    htop
    neovim
    nixVersions.nix_2_19
    imagemagick
    nix-prefetch-github
    nix-prefetch-git
    gthumb
    direnv
    gnome3.adwaita-icon-theme
    arandr
    rustc
    rust-analyzer
    rustup
    zoom-us
    polybar
    xmonad-log
    texliveFull
    vscode
    rocksdb
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.light.enable = true;
  programs.ssh.startAgent = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias  = true;
    vimAlias  = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
 
  virtualisation.docker.enable = true;

  nix = {
    settings.auto-optimise-store = true;
    settings.substituters = [
      "https://cache.nixos.org"
      "https://nixcache.chainweb.com"
      "https://nixcache.reflex-frp.org"
    ];

    settings.trusted-public-keys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      "nixcache.chainweb.com:FVN503ABX9F8x8K0ptnc99XEz5SaA4Sks6kNcZn2pBY="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    settings.build-cores = 2;
    settings.max-jobs = "auto";
    settings.trusted-users = [ "@wheel" ];
    # Turn on nix flakes
    settings.experimental-features = [ "nix-command" "flakes" "recursive-nix" ];
  };

}

