{
  inputs,
  config,
  pkgs,
  ...
}:

{

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hyprgrass
      pkgs.hyprlandPlugins.hyprexpo
      # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprgrass
    ];
    # temporary
    extraConfig = ''
      # syntax: sh
      # even tho it's hyprlang
      $hypr = ~/.config/hypr
      $hl = $hypr/hyprland
      $cConf = ~/.config/caelestia

      # Variables (colours + other vars)
      exec = cp -L --no-preserve=mode --update=none $hypr/scheme/default.conf $hypr/scheme/current.conf
      source = $hypr/scheme/current.conf
      source = $hypr/variables.conf

      # User variables
      exec = mkdir -p $cConf && touch -a $cConf/hypr-vars.conf
      source = $cConf/hypr-vars.conf

      # Default monitor conf
      monitor = , preferred, auto, 1

      # Configs
      source = $hl/env.conf
      source = $hl/general.conf
      source = $hl/input.conf
      source = $hl/misc.conf
      source = $hl/animations.conf
      source = $hl/decoration.conf
      source = $hl/group.conf
      source = $hl/execs.conf
      source = $hl/rules.conf
      source = $hl/gestures.conf
      source = $hl/keybinds.conf

      # User configs
      exec = mkdir -p $cConf && touch -a $cConf/hypr-user.conf
      source = $cConf/hypr-user.conf
    '';
    /*
        # hyprland settings
        settings = {
          bindl = ", switch:on:Lenovo\ Yoga\ Tablet\ Mode\ Control\ switch, exec";

        };
    */
  };

  xdg.configFile."hypr/scripts/osk.sh" = {
    source = ../30.12_Source/scripts/osk.sh;
    executable = true;
  };

}
