{ ... }:

let
  src = ../../../.source;
in
{
  xdg.configFile."gtk-3.0/gtk.css".source = "${src}/gtk/gtk-3.0/gtk.css";
  xdg.configFile."gtk-4.0/gtk.css".source = "${src}/gtk/gtk-4.0/gtk.css";
}
