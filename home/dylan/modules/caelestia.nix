{
  host,
  config,
  lib,
  ...
}:
let
  src = ../../../.source;

  isYoga7 = host == "yoga7amd" || host == "yoga7intel";
  isVengeance = host == "vengeance";
  isG16 = host == "g16";

  hyprVars =
    if isYoga7 then
      "${src}/caelestia/yoga7-vars.conf"
    else if isVengeance then
      "${src}/caelestia/vengeance-vars.conf"
    else if isG16 then
      "${src}/caelestia/g16-vars.conf"
    else
      "${src}/caelestia/hypr-vars.conf";

  hyprUser =
    if isYoga7 then
      "${src}/caelestia/yoga7-user.conf"
    else if isVengeance then
      "${src}/caelestia/vengeance-user.conf"
    else if isG16 then
      "${src}/caelestia/g16-user.conf"
    else
      "${src}/caelestia/hypr-user.conf";
in

{
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      bar.status = {
        showBattery = true;
      };
      paths.wallpaperDir = "~/Pictures/wallpapers";
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = true;
      };
    };
  };

  xdg.configFile = {
    "caelestia/hypr-vars.conf".source = hyprVars;
    "caelestia/hypr-user.conf".source = hyprUser;
  };
}
