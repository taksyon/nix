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

  };

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
    efibootmgr
    elegant-sddm
    fastfetch
    fd
    font-manager
    git
    gparted
    gnome.gvfs
    # gvfs
    htop
    input-remapper
    jq
    kitty
    linux-firmware
    mlocate
    neovim
    home-manager

    util-linux
    kmod
    i2c-tools

    libinput
    # lxqt
    mpv
    nil # nix language server for vscode
    onlyoffice-desktopeditors
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
    vlc
    vscode
    wget
    wine-staging
    winetricks
    wl-clipboard
    xclip
    xdg-utils
    xournalpp
    zathura
    zip
  ];
}
