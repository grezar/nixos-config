{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "grezar";
    userEmail = "grezar.dev@gmail.com";
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      github.user = "grezar";
      push.default = "tracking";
      init.defaultBranch = "main";
    };
  };

  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 18.0;
      };
    };
  };
}
