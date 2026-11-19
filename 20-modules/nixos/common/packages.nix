{ pkgs, ... }:

# System-wide packages: hardware/system tools and GUI apps.
# Per-user CLI and dev tools live in 20-modules/home/common/packages.nix.
{
  environment.systemPackages = with pkgs; [
    alsa-utils
    alsa-ucm-conf
    audacity

    bat
    bat-extras.core
    bibletime
    brightnessctl
    bzip2

    claude-code
    clang-tools
    curl
    snapshot

    dmidecode # https://www.nongnu.org/dmidecode/

    eclipses.eclipse-java
    efibootmgr
    elegant-sddm

    file
    font-manager

    gdu # CLI disk visualization tool
    gparted
    gnome.gvfs
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly

    htop

    image-roll
    i2c-tools
    input-remapper
    kmod

    kitty

    lftp # FTP client
    libinput

    mlocate

    neovim
    nil # nix language server for vscode

    onlyoffice-desktopeditors
    openrgb-with-all-plugins

    photoqt # image viewer

    qbittorrent
    quickshell

    sof-firmware
    sof-tools

    thunderbird

    usbutils
    util-linux

    wget

    xclip
    xdg-utils
    xfce4-settings

    zathura
    zstd
  ];
}
