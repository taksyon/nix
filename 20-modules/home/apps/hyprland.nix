{ pkgs, ... }:

{
  # TODO: convert caelestia config -> here
  wayland.windowManager.hyprland = {
    enable = true; # this will overwrite caelestia's hyprland.conf
    systemd.enable = true;

    # from nixpkgs so the plugin is built against the same Hyprland the system runs
    plugins = [
      pkgs.hyprlandPlugins.hyprgrass
    ];
  };

  home.packages = with pkgs; [
    hyprpicker
  ];
}
