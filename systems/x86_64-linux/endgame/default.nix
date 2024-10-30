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
  # All other arguments come from the system system.
  config,
  hostname,
  ...
}: {
  # This is the main configuration file for my desktop
  # gaming PC (AMD Ryzen 7800X3D, NVIDIA 4070Ti).
  desktop = {
    gnome.enable = true;
  };

  hardware = {
    audio.enable = true;
    networking = {
      enable = true;
      hostname = hostname;
    };
    nvidia.enable = true;
  };

  system = {
    boot.enable = true;
    dbus.enable = true;
    fonts.enable = true;
    kernel.cachy.enable = true;
    locale.enable = true;
    nix.enable = true;
  };

  packages = {
    basics.enable = true;
    development.enable = true;
  };

  gaming = {
    enable = true;
  };

  environment.shells = with pkgs; [fish];
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.velen2077 = {
    isNormalUser = true;
    hashedPassword = "$6$SpG3sYsUt3IxXQLv$1v6tnDzULI4mM6bO.jXbJGuO/7rXcfdKJet4xBcylTG88dDyJrGdNpsKH9/eGwVIFSmQD6lIWWWE4CTUAMI820";
    description = "velen2077";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    createHome = true;
    shell = pkgs.fish;
    packages = with pkgs; [foot];
  };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 8192; # Use 2048MiB memory.
      cores = 4;
    };
  };

  system.stateVersion = "24.11";
}
