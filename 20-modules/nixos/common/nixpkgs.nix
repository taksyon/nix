{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    # download-buffer-size = "512MiB";
  };

  programs.dconf.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };

  programs.obs-studio.enable = true;
}
