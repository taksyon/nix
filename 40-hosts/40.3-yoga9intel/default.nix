{ config, pkgs, ... }:

{
  imports = [
    ../40.1-common/boot.nix
    ../40.1-common/nixos.nix
    ../40.1-common/roles/laptop.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.kernelModules = [
    "i2c_hid"
    "i2c_hid_acpi"
    "hid_multitouch"
  ];

  hardware.enableAllFirmware = true;

  networking.hostName = "yoga9intel";
  services.lact.enable = true;
}
