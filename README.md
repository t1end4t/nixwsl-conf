# My own NixOS config

## NOTE:

1. Command to prevent Github limit

```nu
env NIX_CONFIG="access-tokens = github.com=ghp_my_own_token_here" nix flake update
```

```nu
$env.GITHUB_TOKEN = "ghp_my_own_token_here"
```

2. Put this on nix.conf file

```~/.config/nix/nix.conf
access-tokens = github.com=ghp_my_own_token
```

## Troubleshoot

1. `Bashrc` and `.envrc` error with WSL:

```nu
sed -i 's/\r$//' bashrc
```
