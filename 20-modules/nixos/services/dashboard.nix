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
        theme = "nord-frost";
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
        {
          name = "Top Sites";
          icon = "fas fa-star";
          displayData = {
            cols = 4;
          };
          items = [
            {
              title = "GitHub";
              icon = "fab fa-github";
              url = "https://github.com";
            }
            {
              title = "Gmail";
              icon = "fas fa-envelope";
              url = "https://mail.google.com";
            }
            {
              title = "Calendar";
              icon = "fas fa-calendar";
              url = "https://calendar.google.com";
            }
            {
              title = "Drive";
              icon = "fas fa-cloud";
              url = "https://drive.google.com";
            }
          ];
        }

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
              title = "Grafana";
              icon = "fas fa-chart-area";
              url = "http://127.0.0.1:3000";
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
              url = "http://127.0.0.1:3000";
            }
            {
              title = "Portainer";
              icon = "fab fa-docker";
              url = "http://127.0.0.1:9000";
            }
          ];
        }

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

  # Make it local-only by default (safe baseline across all hosts)
  services.nginx.virtualHosts."dashy.local".listen = [
    {
      addr = "127.0.0.1";
      port = 8080;
    }
  ];
}
