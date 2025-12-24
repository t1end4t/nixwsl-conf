{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    nix-direnv.package = pkgs.nix-direnv; # will get latest
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };
}
