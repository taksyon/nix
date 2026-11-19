{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # your Open GL, Vulkan and VAAPI drivers
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      intel-vaapi-driver
      intel-media-driver
    ];
  };

  services.pulseaudio.enable = false;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  boot.kernelModules = [ "i2c-dev" ];
  hardware.firmware = [
    pkgs.sof-firmware
    pkgs.linux-firmware
  ];

  # prevents overheating on intel CPUs
  services.thermald.enable = true;
  hardware.cpu.intel.updateMicrocode = true;

  programs.iio-hyprland.enable = true;
}
