{ ... }:

{
  imports = [
    ../../../configuration.nix
  ];

  services.tlp.enable = true;

  powerManagement.powertop.enable = true;
}
