{ pkgs, ... }:

{
  # CUPS. Most network printers from the last ~10 years speak IPP Everywhere /
  # AirPrint and need no driver: cups-browsed picks them up via mDNS automatically.
  services.printing = {
    enable = true;
    # fallback drivers for printers that aren't driverless
    drivers = with pkgs; [
      cups-filters
      gutenprint # Canon, Epson, and many others
      hplip # HP
      brlaser # Brother laser
    ];
  };

  # mDNS discovery of network printers (and .local hostname resolution).
  # openFirewall opens UDP 5353 so replies from printers get through.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # GUI for adding/managing printers (no GNOME/KDE settings app on Hyprland)
  programs.system-config-printer.enable = true;

  # lets dylan add/modify printers without sudo
  users.users.dylan.extraGroups = [ "lpadmin" ];
}
