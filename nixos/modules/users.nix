{ config, pkgs, ... }:

{
  users.users.dylan = {
    isNormalUser = true;
    description = "dylan";
    extraGroups = [
      "i2c"
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
