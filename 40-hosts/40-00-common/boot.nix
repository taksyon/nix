{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_stable;

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
}
