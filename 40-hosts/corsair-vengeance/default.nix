{
  config,
  pkgs,
  inputs,
  ...
}:
/*
  let
    nix-gaming = import (
      builtins.fetchTarball {
        url = "https://github.com/fufexan/nix-gaming/archive/master.tar.gz";
        # sha256 = "3c85dac50d8494bba399e94c3ac41a5015fcc13ec4831782b9440dd14cfde9c5";
      }
    );
  in
*/
{
  imports = [
    ../40.1-common/boot.nix
    ../40.1-common/nixos.nix
    ../40.1-common/roles/desktop.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];

  nix.settings = {
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [ "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo=" ];
  };

  boot.kernelPackages = pkgs.linuxPackages;

  # For Star Citizen
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  # See RAM, ZRAM & Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024; # 8 GB Swap
    }
  ];
  zramSwap = {
    enable = true;
    memoryMax = 16 * 1024 * 1024 * 1024; # 16 GB ZRAM
  };

  networking.hostName = "vengeance";

  services.lact.enable = true;

  users.users.dylan = {
    packages = with pkgs; [
      # tricks override to fix audio
      # see https://github.com/fufexan/nix-gaming/issues/165#issuecomment-2002038453
      (inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.star-citizen.override {
        tricks = [
          "arial"
          "vcrun2019"
          "win10"
          "sound=alsa"
        ];
      })
    ];
  };
}
