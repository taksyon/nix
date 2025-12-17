{ config, pkgs, ... }:

{
  imports = [
    ../../20-modules/20.1-nixos/20.11-common/users.nix
    ../../20-modules/20.1-nixos/20.11-common/nixpkgs.nix
    ../../20-modules/20.1-nixos/20.12-services/networking.nix
    ../../20-modules/20.1-nixos/20.12-services/audio.nix
    ../../20-modules/20.1-nixos/20.13-desktop/visual.nix
  ];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.keyMap = "us";

  services.openssh.enable = true;
  services.locate.enable = true; # enables 'locate' command
  programs.firefox.enable = true;
  system.stateVersion = "25.11";
}
