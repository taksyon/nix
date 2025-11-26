{ ... }:

{
  imports = [
    ../../../configuration.nix
  ];

  networking.hostName = "g16";

  services.tlp.enable = true;

  powerManagement.powertop.enable = true;
}
