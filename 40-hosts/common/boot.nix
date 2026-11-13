{ config, pkgs, ... }:

{
  boot = {
    # enables magic REISUB clutch
    kernel.sysctl."kernel.sysrq" = 176;

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
    loader.timeout = 3;
  };
}
