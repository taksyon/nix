{ ... }:

let
  src = ../../../.source;
in
{
  gtk = {
    enable = true;

    colorScheme = "dark";
    font = {
      name = "Cantarell";
      size = 16;
    };
  };
  xdg.configFile."gtk-3.0/gtk.css".source = "${src}/gtk/gtk-3.0/gtk.css";
  xdg.configFile."gtk-4.0/gtk.css".source = "${src}/gtk/gtk-4.0/gtk.css";
  xdg.configFile."btop/btop.conf".source = "${src}/btop/btop.conf";
}
