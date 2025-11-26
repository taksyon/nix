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
    git
    neovim
    wget
    curl
    fastfetch
    nil # nix language server for vscode
    ripgrep
    fd
    btop
    tmux
    htop
    vscode
  ];
}
