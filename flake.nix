{
  description = "velen2077's flaked out Nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Sylix.
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "velen2077s-flaked-out-nix-config";
          title = "velen2077's flaked out Nix config";
        };
        namespace = "nix-config";
      };

      channels-config = {
        allowUnfree = true;
      };

      overlays = [
        inputs.chaotic.overlays.default
      ];

      # Host-specific settings:
      systems.hosts.endgame.specialArgs = {
        hostname = "endgame";
        stateVersion = "24.11";
      };

      systems.host.endgame.modules = with inputs; [
        chaotic.nixosModules.default
      ];

      # Home modules:
      home.modules = with inputs; [
        stylix.homeManagerModules.stylix
        arkenfox.hMModules.default
      ];

      homes.users."velen2077@endgame".specialArgs = {
        hostname = "endgame";
        username = "velen2077";
        stateVersion = "24.11";
      };
    };
}
