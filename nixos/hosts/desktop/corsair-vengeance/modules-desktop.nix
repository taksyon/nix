{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.hyprland.nixosModules.default
  ];
  #### Backlight + brightness control
#  programs.light.enable = true;

  #### AMD iGPU (Radeon 880M / 890M) quirks
  # boot.kernelParams = [
  # "amdgpu.sg_display=0"
  # "amdgpu.dcdebugmask=0x10"
  # ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      #libva-vdpau-driver
      #libvdpau-va-gl
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  #hardware.sensor.iio.enable = true;

  #### Optional battery stretch mode (Yoga has good battery but why not)
  #services.tlp.settings.TLP_DEFAULT_MODE = "BAT";

  #programs.hyprland = {
    #plugins = [
      #inputs.hyprgrass.packages.${pkgs.system}.default
      # optional integration with pulse-audio
      #inputs.hyprgrass.packages.${pkgs.system}.hyprgrass-pulse
    #];
  #};
  #programs.iio-hyprland.enable = true;

  #### Laptop-specific packages
  environment.systemPackages = with pkgs; [
    #wvkbd
    brightnessctl
    #iio-sensor-proxy
    # inputs.iio-hyprland.packages.${pkgs.system}.default
  ];
}
