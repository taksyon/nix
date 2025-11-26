{ ... }:

{
  imports = [
    ../../../../configuration.nix
    ./hardware-configuration.nix
    # ./modules-yoga7-intel.nix
  ];

  hardware.sensor.iio.enable = true;

  networking.hostName = "yoga7intel";
  services.tlp.enable = true;
  services.lact.enable = true;

  powerManagement.powertop.enable = true;
}
