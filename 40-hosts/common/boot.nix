{ pkgs, ... }:

{
  boot = {
    kernel.sysctl."kernel.sysrq" = 176; # enables magic REISUB clutch

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev"; # UEFI: install to the ESP, not an MBR
        configurationLimit = 10;
        useOSProber = true; # picks up Windows / other OSes if present

        theme = "${pkgs.sleek-grub-theme.override { withStyle = "dark"; }}";

        # Theme fonts are fixed-size bitmaps, so render at 1080p rather than
        # native panel res (otherwise the menu is tiny on HiDPI screens).
        # Falls back to the firmware's preferred mode if 1080p isn't offered.
        gfxmodeEfi = "1920x1080,auto";
      };
      efi.canTouchEfiVariables = true;
      timeout = 5;
    };
  };
}
