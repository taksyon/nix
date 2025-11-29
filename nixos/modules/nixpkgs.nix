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
    efibootmgr
    fastfetch
    fd
    git
    gparted
    htop
    input-remapper
    jq
    mlocate
    neovim
    onlyoffice-desktopeditors
    wget
    curl
    fastfetch
    home-manager
    libinput
    mpv
    nil # nix language server for vscode
    prismlauncher
    python3
    qbittorrent
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
