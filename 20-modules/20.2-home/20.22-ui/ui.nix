{ config, pkgs, ... }:

{

  gtk = {
    enable = true;

    colorScheme = "dark";
    font = {
      name = "Cantarell";
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
  };

  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "Colloid";
    color-scheme = "prefer-dark";
  };
}
