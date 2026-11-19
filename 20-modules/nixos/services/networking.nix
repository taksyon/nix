{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  networking.useDHCP = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
    # SSH is only reachable over the tailnet, not the LAN/internet
    interfaces.tailscale0.allowedTCPPorts = [ 22 ];
  };

  services.tailscale.enable = true; # VPN
}
