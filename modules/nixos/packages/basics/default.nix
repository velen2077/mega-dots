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
  cfg = config.packages.basics;
in {
  options.packages.basics = {
    enable = mkOpt types.bool true "Enable basic packages";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age
      bat
      brightnessctl
      btop
      cava
      eza
      fastfetch
      fd
      ffmpeg
      fzf
      git
      glow
      jq
      libnotify
      nh
      nix-index
      nix-output-monitor
      nurl
      obsidian
      pandoc
      rclone
      ripgrep
      signal-desktop
      sops
      spicetify-cli
      spotify
      ssh-to-age
      tree
      unzip
      vim
      vesktop
    ];
  };
}
