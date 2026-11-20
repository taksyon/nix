{ pkgs, ... }:

{
  imports = [
    ../../../20-modules/nixos/apps/virtualisation.nix
    ../../../20-modules/nixos/services/printing.nix
    ./graphical.nix
  ];

  hardware.bluetooth.powerOnBoot = true;

  # ntopng is installed but off at boot to save battery; toggle with `netmon on|off`
  local.netmon.autostart = false;

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = false; # conflicts with TLP

  # logind
  services.logind = {
    settings = {
      Login = {
        HandlePowerKey = "ignore";
        HandlePowerKeyLongPress = "poweroff";
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
      };
    };
  };

  # Power management
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    WIFI_PWR_ON_BAT = "on";
    WIFI_PWR_ON_AC = "off";
    # START_CHARGE_THRESH_BAT0 = 0;
    # STOP_CHARGE_THRESH_BAT0 = 80; # vendor specific. see sudo tlp-stat -b
  };

  # generic laptop tools
  environment.systemPackages = with pkgs; [
    powertop
    acpi
  ];

}
