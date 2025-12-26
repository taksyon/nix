{
  config,
  pkgs,
  lib,
  host,
  ...
}@inputs:

let
  hostModules = {
    yoga7amd = ./30.13_Hosts/yoga7amd.nix;
    yoga9intel = ./30.13_Hosts/yoga9intel.nix;
    asusG16 = ./30.13_Hosts/asusG16.nix;
    vengeance = ./30.13_Hosts/vengeance.nix;
  };

  hostModule = lib.attrByPath [ host ] null hostModules;
in
{
  home.username = "dylan";
  home.homeDirectory = "/home/dylan";

  imports = [
    inputs.caelestia-shell.homeManagerModules.default

    ../../20-modules/20.2-home/20.21-common/git.nix
    ../../20-modules/20.2-home/20.21-common/packages.nix
    ../../20-modules/20.2-home/20.21-common/shell.nix
    ../../20-modules/20.2-home/20.22-ui/ui.nix
    # ../../20-modules/20.2-home/20.23-apps/hyprland.nix
    ../../20-modules/20.2-home/20.23-apps/caelestia.nix
    ../../20-modules/20.2-home/20.23-apps/zathura.nix

  ] # ++ lib.optional (hostModule != null) hostModule
  ;

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "code";
    VISUAL = "nvim";
    PAGER = "more";

  };

  home.stateVersion = "25.11";

  # custom file sourcing
  # xdg.configFile."gtk-3.0/gtk.css".source = ./30.11-source/gtk/gtk-3.0/gtk.css;
  # xdg.configFile."gtk-4.0/gtk.css".source = ./30.11-source/gtk/gtk-4.0/gtk.css;
  # xdg.configFile."btop/btop.conf".source = ./30.11-source/btop/btop.conf;

  #### foot.ini for reference only. do not source. --> /nix/20-modules/20.21-common/shell.nix
  xdg.configFile."foot/foot.ini".source = ./30.12_Source/foot/foot.ini;
  xdg.configFile."caelestia/shell.json".source = ./30.12_Source/caelestia/shell.json;
  xdg.configFile."caelestia/cli.json".source = ./30.12_Source/caelestia/cli.json;

}
