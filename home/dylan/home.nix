{ config, pkgs, ... }@inputs:

{
  home.username = "dylan";
  home.homeDirectory = "/home/dylan";

  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    ./modules/caelestia.nix
    ./modules/git.nix
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/ui.nix
    # ./modules/neovim.nix
  ];

  programs.home-manager.enable = true;
  home-manager.backupFileExtension = "backup";

  home.stateVersion = "25.11";
}
