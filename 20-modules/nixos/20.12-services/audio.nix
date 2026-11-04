{ config, pkgs, ... }:

{

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    # wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # TODO: move this somewhere more user-centric
    strawberry # Music collection organizer
  ];
}
