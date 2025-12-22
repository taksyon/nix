{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # your Open GL, Vulkan and VAAPI drivers
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
      intel-vaapi-driver
      intel-media-driver
    ];
  };

  services.pulseaudio.enable = false;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  # };

  boot.kernelModules = [ "i2c-dev" ];
  /*
    # to fix sound problem on yoga 9i
    systemd.services.turn-on-speakers = {
      description = "Turn on speakers using i2c configuration";
      after = [
        "suspend.target"
        "hibernate.target"
        "hybrid-sleep.target"
        "suspend-then-hibernate.target"
      ];

      serviceConfig = {
        User = "root";
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c \"${./2pa-byps.sh} | ${pkgs.util-linux}/bin/logger\"";
      };
      wantedBy = [
        "multi-user.target"
        "sleep.target"
      ];
    };
  */
  hardware.firmware = [
    pkgs.sof-firmware
    pkgs.linux-firmware
  ];

  # prevents overheating on intel CPUs
  services.thermald.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
}
