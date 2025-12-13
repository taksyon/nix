{ config, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    # download-buffer-size = "512MiB";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    package = pkgs.steam.override {
      extraProfile = ''
        # Fixes timezones on VRChat
        unset TZ
        # Allows Monado to be used
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
      '';
    };
  };

  programs.alvr.enable = true;
  programs.alvr.openFirewall = true;

  fonts.packages = with pkgs; [
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono

  ];

  environment.systemPackages = with pkgs; [
    alsa-utils
    alsa-ucm-conf
    audacity

    bat
    bat-extras.core
    blueman
    brightnessctl
    btop

    clang-tools
    curl

    eclipses.eclipse-java
    efibootmgr
    elegant-sddm

    fastfetch
    fd
    font-manager

    git
    gparted
    gnome.gvfs

    home-manager
    htop

<<<<<<< HEAD
    i2c-tools
    input-remapper
=======
    util-linux
    kmod
    # i2c-tools
>>>>>>> 6f8f23f (update nixpkgs from vengeance)

    jq

    kitty
    kmod

    lftp # FTP client
    libinput
    linux-firmware
    # lxqt

    mlocate
    mpv

    neovim
    nil # nix language server for vscode

    onlyoffice-desktopeditors
    opencomposite # VR
    openrgb-with-all-plugins

    prismlauncher
    python3

    qbittorrent
    quickshell

    ripgrep

    sof-firmware
    sof-tools

    tealdeer
    thunderbird
    tmux

    unzip
    util-linux

    vlc
    vscode

    wget
    wine-staging
    winetricks
    wl-clipboard

    xclip
    xdg-utils
    xfce.xfce4-settings
    xournalpp
    xrizer # VR

    zathura
    zip
  ];
}
