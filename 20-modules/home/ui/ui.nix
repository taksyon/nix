{ config, pkgs, ... }:

{

  gtk = {
    enable = true;

    colorScheme = "dark";
    font = {
      name = "Rubik";
      size = 16;
    };
    theme = {
      name = "Colloid";
      package = pkgs.colloid-gtk-theme;
    };
    iconTheme = {
      name = "Colloid";
      package = pkgs.colloid-icon-theme;
    };
    gtk4 = {
      theme = config.gtk.theme;
    };
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
    gtk-theme = "Colloid";
    color-scheme = "prefer-dark";
  };
}
