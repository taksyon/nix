{ inputs, pkgs, ... }:

{
  imports = [
    inputs.hyprland.nixosModules.default
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  hardware.sensor.iio.enable = true;

  #### Power management
  services.tlp.enable = true;

  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    TLP_DEFAULT_MODE = "BAT";
    WIFI_PWR_ON_BAT = "on";
    WIFI_PWR_ON_AC = "off";
  };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  #### lid behavior
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
      };
    };
  };

  #### bluetooth (usually relevant for all laptops)
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  programs.hyprland = {
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default
      # optional integration with pulse-audio
      inputs.hyprgrass.packages.${pkgs.system}.hyprgrass-pulse
    ];
  };

  programs.iio-hyprland.enable = true;
  #### Backlight + brightness control
  programs.light.enable = true;

  #### generic laptop tools
  environment.systemPackages = with pkgs; [
    wvkbd
    brightnessctl
    iio-sensor-proxy
    powertop
    tlp
    blueman
    acpi
  ];
}
