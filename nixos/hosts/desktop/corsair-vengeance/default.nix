{ ... }:

{
  imports = [
    ../../../configuration.nix
  ];

  networking.hostName = "vengeance";

  services.tlp.enable = false;
  services.lact.enable = true;
}
