{ config, pkgs, ... }:

{
  imports = [
    ../../configuration.nix
  ];

  networking.hostName = "desktop";

  services.tlp.enable = false;
}
