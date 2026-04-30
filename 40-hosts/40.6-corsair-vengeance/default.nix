{
  config,
  pkgs,
  inputs,
  ...
}:
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

<<<<<<< HEAD
<<<<<<< HEAD
=======
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.zpool=z3fold"
    "zswap.max_pool_percent=20"
  ];

  # See RAM, ZRAM & Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 64 * 1024; # 64 GB Swap
    }
  ];
  zramSwap.enable = false;
  /*
    zramSwap = {
      enable = true;
      memoryMax = 16 * 1024 * 1024 * 1024; # 16 GB ZRAM
    };
  */

>>>>>>> d9e700f (removed hosts that I gave away)
=======
>>>>>>> 2b00929 (many changes to shell.json for desktop)
  networking.hostName = "vengeance";

  services.lact.enable = true; # https://mynixos.com/nixpkgs/options/services.lact
  /*
    services.foldingathome = {
      # https://mynixos.com/options/services.foldingathome
      # Protein folding sims -- folding@home
      enable = true;
<<<<<<< HEAD

    };
  */

=======

    };
  */
<<<<<<< HEAD
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
>>>>>>> d9e700f (removed hosts that I gave away)
=======

>>>>>>> 2b00929 (many changes to shell.json for desktop)
}
