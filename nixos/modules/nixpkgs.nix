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

  environment.systemPackages = with pkgs; [
    alsa-utils
    audacity
    bat
    bat-extras.core
    btop
    efibootmgr
    git
    gparted
    input-remapper
    jq
    mlocate
    neovim
    wget
    curl
    fastfetch
    home-manager # for 'home-manager' command
    libinput
    nil # nix language server for vscode
    ripgrep
    fd
    btop
    tmux
    htop
    vscode
    xournalpp
    zathura
    zathura-pdf-mupdf
  ];
}
