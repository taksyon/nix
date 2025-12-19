{
  config,
  pkgs,
  lib,
  ...
}:

{

  # boot loading screen
  boot.plymouth = {
    enable = true;
    theme = "rings";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "rings" ];
      })
    ];
  };

  # enable graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  hardware.bluetooth.enable = true;

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = false; # conflicts with TLP

  # lid behavior
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchDocked = "ignore";
      };
    };
  };

  services.blueman.enable = true;

  # Power management
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    WIFI_PWR_ON_BAT = "on";
    WIFI_PWR_ON_AC = "off";
    START_CHARGE_THRESH_BAT0 = 50;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };

  # generic laptop tools
  environment.systemPackages = with pkgs; [
    brightnessctl
    powertop
    tlp
    blueman
    acpi
  ];

}
