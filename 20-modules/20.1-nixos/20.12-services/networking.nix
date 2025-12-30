{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  networking.useDHCP = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
  };

  services.tailscale.enable = true; # VPN
}
