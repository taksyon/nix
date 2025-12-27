{ ... }:

{
  imports = [
    ../40.1-common/boot.nix
    ../40.1-common/nixos.nix
    ../40.1-common/roles/laptop.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages;

  users.users.dylan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.dylan = import ../../30-home/30-10-dylan/default.nix;

  hardware.sensor.iio.enable = true;

  networking.hostName = "yoga7amd";
  services.tlp.settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
  };
  services.lact.enable = true;

  powerManagement.powertop.enable = true;
}
