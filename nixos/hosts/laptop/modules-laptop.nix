{
  config,
  pkgs,
  lib,
  ...
}:

{
  #### Generic laptop hostname override (optional)
  # networking.hostName = "laptop";

  #### Power management
  services.tlp.enable = true;

  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    WIFI_PWR_ON_BAT = "on";
    WIFI_PWR_ON_AC = "off";
  };

  powerManagement.enable = true;

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
