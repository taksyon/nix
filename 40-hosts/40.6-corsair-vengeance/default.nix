{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../40.1-common/boot.nix
    ../40.1-common/nixos.nix
    ../40.1-common/roles/desktop.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  nix.settings = {
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
  };

  boot.kernelPackages = pkgs.linuxPackages;

  # For Star Citizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  networking.hostName = "vengeance";

  services.lact.enable = true; # https://mynixos.com/nixpkgs/options/services.lact
  /*
    services.foldingathome = {
      # https://mynixos.com/options/services.foldingathome
      # Protein folding sims -- folding@home
      enable = true;

    };
  */

}
