{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}:
with lib;
with lib.nix-config; let
  cfg = config.tools.stylix;
  hostname = cfg.hostname;
  wallpaper = ../../../../assets/wallpaper/wallpaper.jpg;
  cursorSize = 16;
  termFontSize = 15;
  appFontSize = 12;
in {
  imports = [inputs.stylix.homeManagerModules.stylix];
  options.tools.stylix = {
    enable = mkOpt types.bool false "Enable stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;

      opacity.terminal = 0.92;
      image = wallpaper;
      polarity = "dark";
      #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["GeistMono"];};
          name = "GeistMono Nerd Font";
          # package = pkgs.nerdfonts.override { fonts = [ "IosevkaTerm" ]; };
          # name = "IosevkaTerm Nerd Font";
        };
        sansSerif = {
          package = pkgs.nerdfonts.override {fonts = ["Ubuntu"];};
          name = "Ubuntu Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        sizes = {
          applications = appFontSize;
          terminal = termFontSize;
        };
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = cursorSize;
      };
    };
    #
    gtk.iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
