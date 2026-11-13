{ config, pkgs, ... }@inputs:

{
  # TODO: convert caelestia config -> here
  wayland.windowManager.hyprland = {
    enable = true; # this will overwrite caelestia's hyprland.conf
    systemd.enable = true;

    #   plugins = [
    #     inputs.hyprgrass.packages.${pkgs.stdenv.hostPlatform.system}.default
    #     # optional integration with pulse-audio
    #     inputs.hyprgrass.packages.${pkgs.stdenv.hostPlatform.system}.hyprgrass-pulse
    #   ];
    # };

    home.packages = with pkgs; [
      hyprpicker
    ];
  };

}
