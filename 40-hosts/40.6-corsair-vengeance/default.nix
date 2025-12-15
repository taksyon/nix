{ config, pkgs, ... }:

{
  imports = [
    ../40.1-common/boot.nix
    ../40.1-common/nixos.nix
    ../40.1-common/roles/desktop.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  networking.hostName = "vengeance";

  services.lact.enable = true;
}
