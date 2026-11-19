{ ... }:

{
  imports = [
    ./graphical.nix
    ../../../20-modules/nixos/apps/vr.nix
    ../../../20-modules/nixos/apps/virtualisation.nix
  ];

  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;
}
