{
  # home-manager for multiple users
  home-manager.users = {
    "tiendat" = {
      imports = [ ./hosts/tiendat.nix ];
    };

    "nixos" = {
      imports = [ ./hosts/nixos.nix ];
    };
  };
}
