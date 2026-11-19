{ config, pkgs, ... }:

{
  # foot
  programs.foot = {
    enable = true;
    # theme = "selenized-black";

    settings = {
      main = {
        font = "Hack Nerd Font Mono:size=9";
        dpi-aware = "yes";
      };
      colors-dark = {
        alpha = 0.9;
        background = "000000";
      };
      cursor = {
        blink = "yes";
      };
      scrollback = {
        lines = 10000;
        multiplier = 3.0;
      };
    };
  };

  # zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true; # grey inline suggestions from history (→ to accept)
    syntaxHighlighting.enable = true; # commands turn green/red as you type

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true; # prefix a command with a space to keep it out of history
      share = true; # share history between open terminals
    };

    oh-my-zsh = {
      enable = true;
      theme = ""; # prompt comes from starship below
      plugins = [
        "git" # g*, gst, gco, gp... aliases
        "sudo" # press Esc twice to prefix the last command with sudo
        "colored-man-pages"
      ];
    };

    shellAliases = {
      #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      javadocs = "javadoc -d ./docs -sourcepath . *.java";
      fetch = "fastfetch";
      binds = "more ~/.config/keybindings.md";
      qtheme = "qt6ct";

      # Git
      ga = "git add";
      gc = "git commit";

      ip = "ip -c"; # -c = colorize
      nmcli = "nmcli --colors yes -p -m tabular";
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
      aliases = "nvim ~/.dotfiles/nix/20-modules/home/common/shell.nix";

      ll = "ls -l";
      la = "ls -la";
      dots = "nvim ~/.dotfiles/";
      windows = "sudo strings /sys/firmware/acpi/tables/MSDM";
      #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    };
  };

  # prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      directory.truncation_length = 4;
      cmd_duration.min_time = 2000; # show runtime for commands over 2s
    };
  };
}
