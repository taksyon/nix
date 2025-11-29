{ ... }:

{
  hardware.pulseaudio.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };
  hardware.firmware = [
    pkgs.sof-firmware
    pkgs.firmwareLinuxNonfree
  ];
  # prevents overheating on intel CPUs
  services.thermald.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
}
