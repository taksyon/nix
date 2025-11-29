{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    # Communication
    betterdiscordctl
    discord
    signal-desktop
    telegram-desktop

    # Media
    vlc
    mpv

    # Gaming
    steam
    lutris
    heroic
    mangohud
    gamemode
    mangohud
    wine
    winetricks

    # Utilities
    zip
    unzip
    p7zip
    tree
    fastfetch
    ripgrep
    fd
    fzf
    jq
    direnv # for vscode extension
    wget
    curl
    btop
    tmux
    tealdeer # Rust impl of tldr package

    # Build tools
    gcc
    gdb
    gnumake
    cmake
    meson
    ninja
    pkg-config
    llvm
    # clang
    # clang-tools
    rustup
    go
    lua
    ruby
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.black
    python3Packages.isort
    python3Packages.flake8
    python3Packages.mypy
    python3Packages.pylint
    python3Packages.autopep8
    python3Packages.pydocstyle
    nodejs
    yarn
    typescript
    deno
    gopls
    shellcheck

    # Version Control
    git
    git-crypt
    gh

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.iosevka
    app2unit

    # Misc
    jdk21
    nixfmt
    xournalpp
    node2nix
    prismlauncher
    xfce.thunar
    yazi
    pulseaudio
    # pipewire
    pavucontrol
  ];
}
