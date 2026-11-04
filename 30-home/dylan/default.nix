{
  config,
  pkgs,
  lib,
  host,
  ...
}@inputs:

let
  hostModules = {
    yoga9intel = ./hosts/yoga9intel.nix;
    vengeance = ./hosts/vengeance.nix;
  };

  hostModule = lib.attrByPath [ host ] null hostModules;
in
{
  home.username = "dylan";
  home.homeDirectory = "/home/dylan";

  imports = [
    inputs.caelestia-shell.homeManagerModules.default

    ../../20-modules/home/common/git.nix
    ../../20-modules/home/common/packages.nix
    ../../20-modules/home/common/shell.nix
    ../../20-modules/home/ui/ui.nix
    # ../../20-modules/home/apps/hyprland.nix
    ../../20-modules/home/apps/caelestia.nix
    ../../20-modules/home/apps/zathura.nix

  ]
  ++ lib.optional (hostModule != null) hostModule;

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "code";
    VISUAL = "nvim";
    PAGER = "more";

  };

  #
  home.stateVersion = "25.11";

  # custom file sourcing
  # xdg.configFile."gtk-3.0/gtk.css".source = ./source/gtk/gtk-3.0/gtk.css;
  # xdg.configFile."gtk-4.0/gtk.css".source = ./source/gtk/gtk-4.0/gtk.css;
  # xdg.configFile."btop/btop.conf".source = ./source/btop/btop.conf;

  #### foot.ini for reference only. do not source. --> /nix/20-modules/common/shell.nix
  # xdg.configFile."foot/foot.ini".source = ./source/foot/foot.ini;
  # xdg.configFile."caelestia/shell.json".source = ./source/caelestia/shell.json;
  # xdg.configFile."caelestia/cli.json".source = ./source/caelestia/cli.json;

  home.packages = with pkgs; [
    protonvpn-gui
  ];

}
