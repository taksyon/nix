{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl."kernel.sysrq" = 176; # enables magic REISUB clutch

    kernelPatches = [
      {
        name = "Rust support for Linux Kernel";
        patch = null;
        features = {
          rust = true;
        };
      }
    ];

    loader = {
      grub = {
        theme = pkgs.sleek-grub-theme.override {
          withStyle = "dark"; # "light", "dark", "orange", or "bigSur"
          withBanner = "Welcome back!"; # text shown at the top
        };
        configurationLimit = 10;
      };

      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };

  };
}
