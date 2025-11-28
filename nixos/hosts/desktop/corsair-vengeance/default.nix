{ config, pkgs, ... }:

{
  imports = [
    ../../../configuration.nix
    ./hardware-configuration.nix
    ./modules-desktop.nix
  ];

  networking.hostName = "vengeance";

  services.tlp.enable = false;
  services.lact.enable = true;
}
