{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib
, # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs
, # You also have access to your flake's inputs.
  inputs
, # Additional metadata is provided by Snowfall Lib.
  namespace
, # The namespace used for your flake, defaulting to "internal" if not set.
  system
, # The system architecture for this host (eg. `x86_64-linux`).
  target
, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format
, # A normalized name for the system target (eg. `iso`).
  virtual
, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems
, # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config
, ...
}:
with lib;
with lib.nix-config; let
  cfg = config.desktop.gnome;
in
{
  options.desktop.gnome = {
    enable = mkEnableOption "Enable GNOME desktop";
  };

  config = mkIf cfg.enable {
    services.libinput.enable = true;
    # To fix GTK apps:
    programs.dconf.enable = true;
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gedit
      cheese # webcam tool
      gnome-music
       # text editor
      epiphany # web browser
      geary # email reader
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup      
    ]);

    environment.systemPackages = with pkgs; [
      gnome-tweaks
    ];

  };
}
