{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting ""
      set -Ux EDITOR nvim
      set -g theme_nerd_fonts yes
    '';

    shellAliases = {

      javadocs = "javadoc -d ./docs -sourcepath . *.java";
      fetch = "fastfetch";
      binds = "moar ~/.config/keybindings.md";
      qtheme = "qt6ct";

      ip = "ip -c"; # -c = colorize
      nmcli = "nmcli --colors yes -p -m tabular";
      yayfind = "yay -Ss --singlelineresults"; # -S = sync/search, -s = search
      lsblk = "lsblk -o NAME,LABEL,FSTYPE,FSUSE%,SIZE,MOUNTPOINT,UUID";

      sem = "cd ~/Education/bhcc/semesters/";
      gotopal = "cd ~/Education/bhcc/semesters/fall25/pal/";
      gotocpp = "cd ~/Education/bhcc/semesters/spr25/cpp-csc237/";
      gotojava = "cd ~/Education/bhcc/semesters/spr25/java-csc239/";
      gotosql = "cd ~/Education/bhcc/semesters/spr25/sql/";
      gotopy = "cd ~/Education/bhcc/semesters/spr25/code_constructors/python/.venv";

      nconf = "nvim ~/.config/nvim/";
      footconf = "nvim ~/.config/foot/foot.ini";
      gpl = "cp ~/Documents/licenses/gpl/license.txt .";
      aliases = "nvim ~/.dotfiles/nixos/users/dylan.nix";

      ll = "ls -l";
      la = "ls -la";
      dots = "nvim ~/.dotfiles/";
    };
  };
}
