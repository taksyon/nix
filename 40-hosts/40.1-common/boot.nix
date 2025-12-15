{ config, pkgs, ... }:

{
  boot = {
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
  };
}
