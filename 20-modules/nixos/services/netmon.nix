{
  config,
  lib,
  pkgs,
  ...
}:

# Network traffic monitoring with ntopng: http://127.0.0.1:3000
# First login is admin / admin, and ntopng asks you to change it.
let
  cfg = config.local.netmon;
  units = [
    "ntopng.service"
    "redis-ntopng.service"
  ];

  # `netmon on|off|status` toggles ntopng without a rebuild
  netmon = pkgs.writeShellApplication {
    name = "netmon";
    runtimeInputs = [ pkgs.systemd ];
    text = ''
      case "''${1:-status}" in
        on)  sudo systemctl start ${lib.concatStringsSep " " units}
             echo "ntopng running: http://127.0.0.1:${toString cfg.port}" ;;
        off) sudo systemctl stop ${lib.concatStringsSep " " units}
             echo "ntopng stopped" ;;
        status) systemctl is-active ntopng.service || true ;;
        *) echo "usage: netmon [on|off|status]" >&2; exit 1 ;;
      esac
    '';
  };
in
{
  options.local.netmon = {
    autostart = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Start ntopng at boot. When false, use `netmon on` to start it.";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
    };
  };

  config = {
    services.ntopng = {
      enable = true;
      httpPort = cfg.port;
      # written out in full so the web UI binds to localhost only
      configText = ''
        --interface=any
        --http-port=127.0.0.1:${toString cfg.port}
        --redis=${config.services.redis.servers.ntopng.unixSocket}
        --data-dir=/var/lib/ntopng
        --user=ntopng
      '';
    };

    systemd.services = lib.mkIf (!cfg.autostart) {
      ntopng.wantedBy = lib.mkForce [ ];
      redis-ntopng.wantedBy = lib.mkForce [ ];
    };

    environment.systemPackages = [ netmon ];
  };
}
