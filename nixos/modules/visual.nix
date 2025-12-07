{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;

  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true; # settings for thunar?
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.hardware.openrgb = {
    enable = true;
    # optional if you want plugins:
    package = pkgs.openrgb-with-all-plugins;
  };
  # If you aren’t already in the right groups:
  users.users.dylan.extraGroups = [
    # "i2c"
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

  # VR
  services.monado = {
    enable = true;
    defaultRuntime = true; # Register as default OpenXR runtime
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
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
