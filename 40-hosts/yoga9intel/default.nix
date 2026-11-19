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

  # Panel Replay off, PSR capped at PSR1 (saves battery on a static screen).
  # If stutter returns, try xe.enable_psr=0. The 120Hz dips on battery were TLP's
  # GPU power profile, see INTEL_GPU_POWER_PROFILE_ON_BAT below.
  boot.kernelParams = [
    "xe.enable_panel_replay=0"
    "xe.enable_psr=1"
  ];

  hardware.enableAllFirmware = true;

  networking.hostName = "yoga9intel";
  services.lact.enable = true;
  services.tlp.settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
    # TLP defaults the xe GPU to "power_saving" on battery, which downclocks so
    # hard between frames that 120Hz animations drop to ~60fps in bursts.
    INTEL_GPU_POWER_PROFILE_ON_BAT = "base";
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
