{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;

  };

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
    wl-clipboard
    grim
    slurp
    # haskellPackages.qt
  ];
}
