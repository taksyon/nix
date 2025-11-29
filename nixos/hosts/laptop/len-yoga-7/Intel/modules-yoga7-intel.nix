{ ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # your Open GL, Vulkan and VAAPI drivers
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      vaapiIntel
      intel-media-driver
      

    ];
  };
  hardware.pulseaudio.enable = false;
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
