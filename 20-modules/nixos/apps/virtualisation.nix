{ ... }:

{
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
  virtualisation.docker.enable = true;

  users.users.dylan.extraGroups = [
    "docker"
    "vboxusers"
  ];
}
