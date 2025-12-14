{ config, pkgs, ... }:

{
  users.users.dylan = {
    isNormalUser = true;
    description = "dylan";
    extraGroups = [
      "audio"
      "i2c"
      "input"
      "networkmanager"
      "vboxusers"
      "video"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
