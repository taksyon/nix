{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.dashy;
in
{
  services.dashy = {
    enable = true;

    # Generic settings for all hosts
    settings = {
      pageInfo = {
        title = "Dashboard";
        description = "Local portal: links, services, and infra.";
        navLinks = [
          {
            title = "Docs";
            path = "https://dashy.to/docs";
          }
          {
            title = "Workspace";
            path = "http://dashy.local/workspace";
          }
          {
            title = "NixOS Options";
            path = "https://search.nixos.org/options";
          }
          {
            title = "Nixpkgs";
            path = "https://search.nixos.org/packages";
          }
        ];
      };

      appConfig = {
        theme = "one-dark";
        layout = "auto";
        iconSize = "medium";
        language = "en";
        statusCheck = true;
        statusCheckInterval = 60;

        # Nice defaults
        openingMethod = "newtab";
        disableConfiguration = true; # static build anyway; hides edit UI bits
      };

      sections = [
        # Section ____________________
        {
          name = "Top Sites";
          icon = "fas fa-star";
          displayData = {
            cols = 4;
          };
          items = [
            {
              title = "GitHub";
              icon = "si-github";
              url = "https://github.com";
            }
            {
              title = "Gmail";
              icon = "si-gmail";
              url = "https://mail.google.com";
            }
            {
              title = "Calendar";
              icon = "mdi-calendar-blank-outline";
              url = "https://icloud.com/calendar";
            }
            {
              title = "iCloud";
              icon = "mdi-cloud";
              url = "https://icloud.com";
            }
          ];
        }

        # Section ____________________
        {
          name = "NixOS";
          icon = "fas fa-snowflake";
          displayData = {
            cols = 4;
          };
          items = [
            {
              title = "NixOS Wiki";
              icon = "fas fa-book";
              url = "https://nixos.wiki";
            }
            {
              title = "Options Search";
              icon = "fas fa-sliders";
              url = "https://search.nixos.org/options";
            }
            {
              title = "Package Search";
              icon = "fas fa-box";
              url = "https://search.nixos.org/packages";
            }
            {
              title = "Home Manager Manual";
              icon = "fas fa-house";
              url = "https://nix-community.github.io/home-manager/";
            }
          ];
        }

        # Section ____________________
        {
          name = "Local Services (common ports)";
          icon = "fas fa-server";
          displayData = {
            cols = 3;
          };
          items = [
            {
              title = "Dashy";
              icon = "fas fa-table-cells";
              url = "http://127.0.0.1/";
            }
            {
              title = "ntopng";
              description = "Network traffic + alerts (laptop: `netmon on`)";
              icon = "fas fa-network-wired";
              url = "http://127.0.0.1:${toString config.local.netmon.port}";
            }
            {
              title = "Grafana";
              icon = "fas fa-chart-area";
              url = "http://127.0.0.1:3002";
            }
            {
              title = "Uptime Kuma";
              icon = "fas fa-heartbeat";
              url = "http://127.0.0.1:3001";
            }
            {
              title = "Prometheus";
              icon = "fas fa-fire";
              url = "http://127.0.0.1:9090";
            }
            {
              title = "Netdata";
              icon = "fas fa-wave-square";
              url = "http://127.0.0.1:19999";
            }
            {
              title = "Syncthing";
              icon = "fas fa-sync";
              url = "http://127.0.0.1:8384";
            }
            {
              title = "Gitea/Forgejo";
              icon = "fab fa-git-alt";
              url = "http://127.0.0.1:3003";
            }
            {
              title = "Portainer";
              icon = "fab fa-docker";
              url = "http://127.0.0.1:9000";
            }
          ];
        }

        # Section ____________________
        {
          name = "Homelab (placeholders)";
          icon = "fas fa-network-wired";
          displayData = {
            cols = 3;
          };
          items = [
            {
              title = "Router";
              icon = "fas fa-network-wired";
              url = "http://192.168.1.1";
              statusCheck = false;
            }
            {
              title = "NAS";
              icon = "fas fa-hard-drive";
              url = "http://nas.local";
              statusCheck = false;
            }
            {
              title = "Home Assistant";
              icon = "fas fa-house";
              url = "http://homeassistant.local:8123";
              statusCheck = false;
            }
          ];
        }

        # Section ____________________
        {
          name = "Crypto (links for now)";
          icon = "fab fa-bitcoin";
          displayData = {
            cols = 3;
          };
          items = [
            {
              title = "CoinGecko";
              icon = "fas fa-coins";
              url = "https://www.coingecko.com";
            }
            {
              title = "CoinMarketCap";
              icon = "fas fa-chart-line";
              url = "https://coinmarketcap.com";
            }
            {
              title = "TradingView";
              icon = "fas fa-chart-candlestick";
              url = "https://www.tradingview.com";
            }
          ];
        }

        # Section ____________________
        {
          name = "Notes";
          icon = "fas fa-note-sticky";
          displayData = {
            cols = 2;
          };
          items = [
            {
              title = "Roadmap";
              icon = "fas fa-list-check";
              url = "https://dashy.to/docs/configuring/";
              description = "Later: per-host overrides, NAS links, Grafana embeds, auth via nginx.";
            }
          ];
        }
      ];
    };

    # nginx front (domain can be overridden per-host later if you want)
    virtualHost = {
      enableNginx = true;
      domain = "dashy.local";
    };
  };

  # Local-only on port 80 (safe baseline across all hosts; the firewall keeps 80 closed anyway).
  # default = true makes it answer for http://localhost and http://127.0.0.1 too,
  # not only for the dashy.local hostname.
  services.nginx.virtualHosts.${cfg.virtualHost.domain} = {
    default = true;
    listen = [
      {
        addr = "127.0.0.1";
        port = 80;
      }
    ];
  };

  # so http://dashy.local resolves on this machine
  networking.hosts."127.0.0.1" = [ cfg.virtualHost.domain ];
}
