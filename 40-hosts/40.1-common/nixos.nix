{ config, pkgs, ... }:

{
  imports = [
    ../../20-modules/20.1-nixos/20.11-common/users.nix
    ../../20-modules/20.1-nixos/20.11-common/nixpkgs.nix
    ../../20-modules/20.1-nixos/20.12-services/networking.nix
    ../../20-modules/20.1-nixos/20.12-services/dashboard.nix
    ../../20-modules/20.1-nixos/20.12-services/power.nix
    ../../20-modules/20.1-nixos/20.12-services/audio.nix
    ../../20-modules/20.1-nixos/20.12-services/services.nix
    ../../20-modules/20.1-nixos/20.13-desktop/visual.nix
  ];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.keyMap = "us";

  services.openssh.enable = true;
  services.locate.enable = true; # enables 'locate' command

  # Default browser
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"

      # ---- PREFERENCES ----
      # Check about:config for options.
      Preferences = {
        /*
          "browser.contentblocking.category" = {
                Value = "strict";
                Status = "locked";
              };
        */
        # "extensions.pocket.enabled" = false;
        # "extensions.screenshots.disabled" = true;
        # "browser.topsites.contile.enabled" = false;
        # "browser.formfill.enable" = false;
        # "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        # "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      };

      # ---- EXTENSIONS ----
      # Check about:support for extension/add-on ID strings.
      # install_url: "https://addons.mozilla.org/firefox/downloads/latest/<APP-ID>/latest.xpi"
      # installation_mode options: "allowed", "blocked","force_installed" and "normal_installed".
      ExtensionSettings = {
        # "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
          installation_mode = "normal_installed";
          private_browsing = true;
        };
        # Privacy Badger:
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/jid1-MnnxcxisBPnSXQ@jetpack/latest.xpi";
          installation_mode = "normal_installed";
          private_browsing = true;
        };
        # Dark Reader:
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4638146/darkreader-4.9.118.xpi";
          installation_mode = "normal_installed";
        };
      };
    };
  };
  environment.sessionVariables = {
    # Firefox: improves touchscreen support and enables more touchpad gestures
    MOZ_USE_XINPUT2 = "1";
  };
  system.stateVersion = "25.11";
}
