{ config, pkgs, ... }:

{
  users.users.dylan = {
    isNormalUser = true;
    description = "dylan";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}