{
  host,
  lib,
  ...
}:

{
  imports = [
    ../../configuration.nix
  ]
  ++ (
    if host == "yoga7amd" then
      [ ./len-yoga-7/AMD/hardware-configuration.nix ]
    else
      [ ./len-yoga-7/Intel/hardware-configuration.nix ]
  );

  services.tlp.enable = true;

  powerManagement.powertop.enable = true;
}
