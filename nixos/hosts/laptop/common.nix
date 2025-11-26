# nixos/hosts/laptop/common.nix
{ home-manager, ... }:

[
  ./default.nix
  ./modules-laptop.nix

  home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.dylan = import ../../../home/dylan/home.nix;
  }
]
