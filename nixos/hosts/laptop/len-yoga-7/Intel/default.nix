{ ... }:

{
  imports = [
    ../../../../configuration.nix
    ./hardware-configuration.nix
    # ./modules-yoga7-intel.nix
  ];

  boot.kernelModules = [
    "i2c_hid"
    "i2c_hid_acpi"
    "hid_multitouch"
  ];

  hardware.enableAllFirmware = true;

  hardware.sensor.iio.enable = true;

  networking.hostName = "yoga7intel";
  services.tlp.enable = true;
  services.lact.enable = true;

  powerManagement.powertop.enable = true;
}
