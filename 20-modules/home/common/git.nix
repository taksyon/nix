{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "dylan";
        email = "dylanmyers316@gmail.com";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
