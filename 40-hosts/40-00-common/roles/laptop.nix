{
  host,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  #### Power management
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    WIFI_PWR_ON_BAT = "on";
    WIFI_PWR_ON_AC = "off";
    START_CHARGE_THRESH_BAT0 = 50;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  # powertop has USB auto-suspend default
  # can make keyboard unresponsive after suspend
  # powerManagement.powertop.enable = true;

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

  #### generic laptop tools
  environment.systemPackages = with pkgs; [
    brightnessctl
    powertop
    tlp
    blueman
    acpi
  ];

}
