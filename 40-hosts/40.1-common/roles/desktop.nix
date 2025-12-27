{ config, pkgs, ... }:

{
  # enable graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      /*
        Video Acceleration API (Intel-originated)
        ↑↓
        Video Decode and Presentation API for Unix (NVIDIA-originated)
      */
      libva-vdpau-driver # VA-API → VDPAU translation
      libvdpau-va-gl # VDPAU → VA-API translation via OpenGL
    ];
  };
  hardware.bluetooth.enable = true;
  boot.plymouth = {
    enable = true;
    theme = "rings";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "rings" ];
      })
    ];
  };

  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;
}
