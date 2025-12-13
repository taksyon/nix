{ config, pkgs, ... }:

{
  imports = [
    # ./hardware-configuration.nix
    ./modules/audio.nix
    ./modules/networking.nix
    ./modules/nixpkgs.nix
    ./modules/users.nix
    ./modules/visual.nix
  ];

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # kernel doesn't have rust support by default; enable it here
    kernelPatches = [
      {
        name = "Rust support for Linux Kernel";
        patch = null;
        features = {
          rust = true;
        };
      }
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };

  };

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
  programs.firefox.enable = true;
  services.openssh.enable = true;
  services.locate.enable = true; # enables 'locate' command
  system.stateVersion = "25.11";
}
