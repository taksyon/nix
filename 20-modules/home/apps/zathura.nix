{ ... }:
{
  # zathura dark mode
  xdg.configFile."zathura/zathurarc".text = ''
    # syntax: sh
      set default-bg "#020424"
      set default-fg "#d4d4d4"
      set recolor "true"
      set recolor-keep "true"
      set recolor-lightcolor "#000000"
      set recolor-darkcolor "#c5c5c5"
  '';
}
