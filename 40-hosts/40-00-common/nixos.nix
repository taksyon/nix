{
  config,
  pkgs,
  home-manager,
  ...
}:

{

  services.tailscale = {
    enable = true;
  };
}
