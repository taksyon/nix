{ config, pkgs, ... }:

{

  gtk = {
    enable = true;

    colorScheme = "dark";
    font = {
      name = "Rubik";
      size = 16;
    };
    # Caelestia (cli.settings.theme.enableGtk) owns GTK styling: it hard-codes
    # adw-gtk3-dark + Papirus in dconf and writes wallpaper-matched colours to
    # ~/.config/gtk-{3,4}.0/gtk.css. These just have to match and be installed.
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    # don't let HM write gtk-4.0/gtk.css; Caelestia writes that file
    gtk4.theme = null;
  };

  fonts = {
    fontconfig.defaultFonts = {
      sansSerif = [
        "Rubik"
      ];
      serif = [ "Rubik" ];
      monospace = [ "Hack Nerd Font" ]; # whatever you use now
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "adw-gtk3-dark";
    icon-theme = "Papirus-Dark";
    color-scheme = "prefer-dark";
  };

  # Polkit authentication agent: shows the password / fingerprint prompt when an
  # app asks for privileges (fprintd-enroll, mounting drives, pkexec, 1Password
  # system unlock...). Without one, polkit silently denies those requests.
  # Runs as a user service on graphical-session.target (started by UWSM).
  services.hyprpolkitagent.enable = true;
}
