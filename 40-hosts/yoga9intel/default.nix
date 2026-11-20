{ config, pkgs, ... }:

{
  imports = [
    ../common/boot.nix
    ../common/nixos.nix
    ../common/roles/laptop.nix
    ./hardware-configuration.nix
    ./modules.nix
    ../../20-modules/nixos/services/fingerprint.nix
  ];

  # change back to testing if sound no workey
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [
    "i2c_hid"
    "i2c_hid_acpi"
    "hid_multitouch"
    "btusb"
  ];

  # Panel Replay off, PSR capped at PSR1. The stutter after idle turned out to be
  # the GPU clock, not PSR/DC states (see INTEL_GPU_* below); if a hitch on the
  # first frame after a static screen ever shows up, try xe.enable_psr=0.
  boot.kernelParams = [
    "xe.enable_panel_replay=0"
    "xe.enable_psr=1"
  ];

  hardware.enableAllFirmware = true;

  networking.hostName = "yoga9intel";
  # LACT off: with no GPU config of its own, it "reapplies" stock clocks on every
  # DRM event (e.g. Hyprland starting), wiping TLP's INTEL_GPU_* settings below.
  services.lact.enable = false;
  services.tlp.settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
    # 120Hz stutter fix (Lunar Lake / xe). Input was clean; Hyprland missed frames
    # because the GPU idles near 100MHz while typing and ramps up too slowly when a
    # workspace swipe / animation starts (choppy, then suddenly smooth).
    # - "power_saving" (TLP's battery default) makes the downclocking even harsher
    # - raising the floor to 800MHz removes the ramp; RC6 still idles the GPU fully
    INTEL_GPU_POWER_PROFILE_ON_BAT = "base";
    # TLP only applies MIN when MAX is set too (else: "frequency invalid")
    INTEL_GPU_MIN_FREQ_ON_AC = 800;
    INTEL_GPU_MAX_FREQ_ON_AC = 1950;
    INTEL_GPU_MIN_FREQ_ON_BAT = 800;
    INTEL_GPU_MAX_FREQ_ON_BAT = 1950;
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
