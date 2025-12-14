{ ... }:

{
  imports = [
    ../../../configuration.nix
    ./hardware-configuration.nix
    ./modules-yoga7-amd.nix
  ];

  hardware.sensor.iio.enable = true;

  networking.hostName = "yoga7amd";
  services.tlp.enable = true;
  services.lact.enable = true;

  powerManagement.powertop.enable = true;
}
