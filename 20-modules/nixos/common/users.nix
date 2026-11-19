{ config, pkgs, ... }:

{
  users.users.dylan = {
    isNormalUser = true;
    description = "dylan";
    extraGroups = [
      "audio"
      "i2c"
      "input"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  # Home Manager's dconf step runs at boot before the user session exists. Without this,
  # GIO starts gvfsd, which mounts a crashing FUSE fs at ~/.gvfs (no XDG_RUNTIME_DIR yet)
  # and Thunar keeps landing in it.
  systemd.services.home-manager-dylan.environment = {
    GIO_USE_VFS = "local";
    GVFS_DISABLE_FUSE = "1";
  };

  programs.zsh.enable = true; # system-wide zsh (login shell, completions for system pkgs)
  environment.pathsToLink = [ "/share/zsh" ]; # lets HM's zsh complete system packages
  programs.ssh.startAgent = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
