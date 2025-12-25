let
  ROOT = builtins.toString ./.;
in
{
  programs.bash = {
    enable = true; # see note on other shells below
    bashrcExtra = builtins.readFile "${ROOT}/bashrc";
  };
}
