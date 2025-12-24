{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    betterdiscordctl
    discord
    signal-desktop
    telegram-desktop

    vlc
    mpv

    # steam
    lutris
    heroic
    mangohud
    gamemode
    mangohud
    wine
    winetricks
    cabextract
    inkscape # vector gfx editor

    zip
    unzip
    p7zip
    tree
    fastfetch
    ripgrep
    fd
    fzf
    hyprls
    jq
    direnv # for vscode extension
    wget
    curl
    btop
    tmux
    tealdeer # Rust impl of tldr package

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

    git
    git-crypt
    gh

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
    yazi
    pulseaudio
    pavucontrol
  ];

  # # For Monado:
  # xdg.configFile."openxr/1/active_runtime.json".source =
  #   "${pkgs.monado}/share/openxr/1/openxr_monado.json";

  # # # For WiVRn v0.22 and below:
  # # xdg.configFile."openxr/1/active_runtime.json".source =
  # #   "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";

  # xdg.configFile."openvr/openvrpaths.vrpath".text = ''
  #   {
  #     "config" :
  #     [
  #       "${config.xdg.dataHome}/Steam/config"
  #     ],
  #     "external_drivers" : null,
  #     "jsonid" : "vrpathreg",
  #     "log" :
  #     [
  #       "${config.xdg.dataHome}/Steam/logs"
  #     ],
  #     "runtime" :
  #     [
  #       "${pkgs.opencomposite}/lib/opencomposite"
  #     ],
  #     "version" : 1
  #   }
  # '';

}
