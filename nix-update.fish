#!/usr/bin/env fish
# Update nixpkgs and home-manager together so their versions stay in sync.
# Usage: nix-update.fish [flake-dir]   (defaults to ~/nix)

set -l flake_dir ~/nix
if test (count $argv) -ge 1
    set flake_dir $argv[1]
end

if not test -f $flake_dir/flake.nix
    echo "No flake.nix found in $flake_dir" >&2
    exit 1
end

echo "Updating nixpkgs and home-manager in $flake_dir..."
nix flake update nixpkgs home-manager --flake $flake_dir
or exit 1

echo ""
echo "Done! Now rebuild with:"
echo "  sudo nixos-rebuild switch --flake $flake_dir"
