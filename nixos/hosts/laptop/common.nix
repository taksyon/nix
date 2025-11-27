# nixos/hosts/laptop/common.nix
{ home-manager, ... }:

[
  ./default.nix
  ./modules-laptop.nix

  home-manager.nixosModules.home-manager
  {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.dylan = import ../../../home/dylan/home.nix;
    };
  }
]
