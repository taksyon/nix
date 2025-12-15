{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  hardware.sensor.iio.enable = true;

  programs.hyprland = {
    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default
      # optional integration with pulse-audio
      inputs.hyprgrass.packages.${pkgs.system}.hyprgrass-pulse
    ];
  };

  programs.iio-hyprland.enable = true;
  programs.light.enable = true; # Backlight control

  services.libinput = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wvkbd # on screen keyboard
    iio-sensor-proxy # touchscreen sensor for gestures
  ];
}
