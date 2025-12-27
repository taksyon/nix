{ config, pkgs, ... }:

{
  imports = [
    ../40.1-common/boot.nix
    ../40.1-common/nixos.nix
    ../40.1-common/roles/laptop.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # change back to testing if sound no workey
  boot.kernelPackages = pkgs.linuxPackages_testing;
  boot.kernelModules = [
    "i2c_hid"
    "i2c_hid_acpi"
    "hid_multitouch"
  ];

  hardware.enableAllFirmware = true;

  networking.hostName = "yoga9intel";
  services.lact.enable = true;
  services.tlp.settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
  };

  # force refresh rate back to 120hz after resume from sleep
  systemd.services.force-cpu-governor-resume = {
    description = "Force CPU governor after resume";
    wantedBy = [ "post-resume.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'for g in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo schedutil > $g; done'";
    };
  };
}
