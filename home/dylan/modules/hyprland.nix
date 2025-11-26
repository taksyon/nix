{ config, pkgs, ... }@inputs:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    plugins = [
      inputs.hyprgrass.packages.${pkgs.system}.default
      # optional integration with pulse-audio
      inputs.hyprgrass.packages.${pkgs.system}.hyprgrass-pulse
    ];
  };
}
