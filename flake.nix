{
  description = "t1endat's config for NixOs";

  # caching
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NOTE: catppuccin for nix, change release because it break!
    # catppuccin.url = "github:catppuccin/nix";
    catppuccin.url = "github:catppuccin/nix/release-25.05";

    # non-flake repositories
    nushell-defaultConfig = {
      url = "github:nushell/nushell";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nushell-defaultConfig,
      catppuccin,
      ...
    }@inputs:
    let
      # custom user and host
      users = [
        "icslab"
      ];

      userToAttrs = builtins.listToAttrs (
        builtins.map (user: {
          name = user;
          value = null;
        }) users
      );

      inherit (self) outputs;
    in
    {
      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = builtins.mapAttrs (
        user: value:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit
              inputs
              outputs
              nushell-defaultConfig
              ;
          };
          modules = [
            ./hosts/${user}.nix
            catppuccin.homeModules.catppuccin
          ];
        }
      ) userToAttrs;
    };
}
