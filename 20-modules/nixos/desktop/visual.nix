{
  config,
  pkgs,
  ...
}@inputs:

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
      thunar-vcs-plugin # adds git to thunar
      thunar-media-tags-plugin
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

  services.xserver = {
    enable = true;

  };

  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
  };

  programs.qylock = {
    enable = true;
    theme = "clockwork"; # any directory name under themes/
    # sddm.enable = true;             # installs theme + sets it active (default)
    # quickshell.enable = true;       # adds `qylock-lock` to PATH (default)

    # Optional per-theme tweaks (replaces the interactive prompts):
    themeOptions = {
      terraria.backgroundMode = "time"; # time | random | static
      Genshin.backgroundMode = "time";
      clockwork.orbital = {
        themeMode = "dark";
        enableWindup = true;
      };
      osu.gameMode = "menu"; # menu | game
    };
  };

  qt = {
    enable = true;
    style = "adwaita-dark";
    # platformTheme = "qt5ct";
    platformTheme = "kde";
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
    sddm-astronaut
    foot
    hypridle
    hyprlock
    kdePackages.qt6ct
    wl-clipboard
    grim

    # Qt
    kdePackages.qtbase
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtmultimedia
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtbase
    kdePackages.qt5compat

    slurp
  ];
}
