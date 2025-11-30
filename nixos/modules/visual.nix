{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;

  };

  services.hardware.openrgb = {
    enable = true;
    # optional if you want plugins:
    package = pkgs.openrgb-with-all-plugins;
  };
  # If you aren’t already in the right groups:
  users.users.dylan.extraGroups = [
    "i2c"
    "video"
    "input"
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "elegant-sddm";
  };
  qt = {
    enable = true;
    style = "adwaita-highcontrast";
    platformTheme = "lxqt";
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  # Wayland portals (screenshare, file pickers, etc.)
  xdg.portal = {
    enable = true;
    lxqt = {
      enable = true;
      styles = [
        pkgs.libsForQt5.qtstyleplugin-kvantum
      ];
    };
    # extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  environment.systemPackages = with pkgs; [
    foot
    hypridle
    hyprlock
    kdePackages.qt6ct
    wl-clipboard
    grim
    slurp
    # haskellPackages.qt
  ];
}
