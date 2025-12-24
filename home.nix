{
  # home-manager for multiple users
  home-manager.users = {
    "icslab" = {
      imports = [ ./hosts/icslab.nix ];
    };
  };
}
