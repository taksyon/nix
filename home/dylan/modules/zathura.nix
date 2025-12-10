{ ... }:
{
  # zathura dark mode
  xdg.configFile."zathura/zathurarc".text = ''
    set default-bg "#1a1a1c"
    set default-fg "#e5e5e5"
    set recolor "true"
    set recolor-keep "true"
    set recolor-lightcolor "#e5e5e5"
    set recolor-darkcolor "#1a1a1c"
  '';
}
