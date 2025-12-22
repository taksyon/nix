{
  host,
  inputs,
  config,
  lib,
  ...
}:
let
  src = "${inputs.self}/30-home/30.1-dylan/30.11-source";

  isYoga7Amd = host == "yoga7amd";
  isYoga9Intel = host == "yoga9intel";
  isVengeance = host == "vengeance";

  hyprVars =
    if isYoga9Intel then
      "${src}/caelestia/yoga9intel-vars.conf"
    else if isVengeance then
      "${src}/caelestia/vengeance-vars.conf"
    else
      "${src}/caelestia/hypr-vars.conf";

  hyprUser =
    if isYoga9Intel then
      "${src}/caelestia/yoga9intel-user.conf"
    else if isVengeance then
      "${src}/caelestia/vengeance-user.conf"
    else
      "${src}/caelestia/hypr-user.conf";
in
{
  programs.caelestia = {
    enable = true;

    systemd = {
      enable = false;
      target = "graphical-session.target";
      environment = [ ];
    };

    settings = {
      appearance = {
        font = {
          family = {
            clock = "Rubik";
            material = "Material Symbols Rounded";
            mono = "Hack Nerd Font Mono";
            sans = "Rubik";
          };
          size.scale = 1.3;
        };
        padding.scale = 1;
        rounding.scale = 1;
        spacing.scale = 1;
        transparency = {
          enabled = true;
          base = 0.85;
          layers = 0.4;
        };
      };

      bar = {
        clock.showIcon = false;
        # status = {
        # showAudio = true;
        # showBattery = false;
        # };
      };

      general.idle.timeouts = [
        {
          timeout = 800;
          idleAction = "lock";
        }
        # {
        # timeout = 1200;
        # idleAction = "dpms off";
        # returnAction = "dpms on";
        # }
        {
          timeout = 1600;
          idleAction = [
            "systemctl"
            "suspend-then-hibernate"
          ];
        }
      ];

      paths.wallpaperDir = "~/Pictures/Wallpapers";
    };

    cli = {
      enable = true;
      settings.theme = {
        enableBtop = true;
        enableDiscord = true;
        enableHypr = true;
        enableTerm = true;
        enableGtk = false;
        enableQt = true;
      };
    };
  };

  xdg.configFile."caelestia/hypr-vars.conf".source = hyprVars;
  xdg.configFile."caelestia/hypr-user.conf".source = hyprUser;
}
