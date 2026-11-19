#!/usr/bin/env bash
# Update all flake inputs.
# Usage: nix-update.sh [flake-dir]   (defaults to ~/.dotfiles/nix)
set -euo pipefail

flake_dir="${1:-$HOME/.dotfiles/nix}"

if [[ ! -f "$flake_dir/flake.nix" ]]; then
    echo "No flake.nix found in $flake_dir" >&2
    exit 1
fi

echo "Updating flake inputs in $flake_dir..."
nix flake update --flake "$flake_dir"

echo ""
echo "Done! Now rebuild with:"
echo "  sudo nixos-rebuild switch --flake $flake_dir"
