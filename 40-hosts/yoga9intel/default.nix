{ config, pkgs, ... }:

{
  imports = [
    ../common/boot.nix
    ../common/nixos.nix
    ../common/roles/laptop.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # change back to testing if sound no workey
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [
    "i2c_hid"
    "i2c_hid_acpi"
    "hid_multitouch"
    "btusb"
  ];

  # possible fix for panel refresh rate battery saver issue
  boot.kernelParams = [
    "xe.enable_panel_replay=0"
    "xe.enable_psr=1"
  ];

  hardware.enableAllFirmware = true;

  networking.hostName = "yoga9intel";
  services.lact.enable = true;
  services.tlp.settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
  };

  # force refresh rate back to 120hz after resume from sleep
  #  systemd.services.force-cpu-governor-resume = {
  #   description = "Force CPU governor after resume";
  #   wantedBy = [ "post-resume.target" ];

  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${pkgs.bash}/bin/bash -c 'for g in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo schedutil > $g; done'";
  #   };
  # };
}
