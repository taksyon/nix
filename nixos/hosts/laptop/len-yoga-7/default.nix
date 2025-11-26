{ ... }:

{
  imports = [
    ../../../configuration.nix
  ];

  networking.hostName = "yoga7";

  services.tlp.enable = true;

  powerManagement.powertop.enable = true;
}
