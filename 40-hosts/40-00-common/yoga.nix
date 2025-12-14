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
  hardware.sensor.iio.enable = true;

  services.libinput = {
    enable = true;
  };

  #### generic laptop tools
  environment.systemPackages = with pkgs; [
    wvkbd
    iio-sensor-proxy
  ];
}
