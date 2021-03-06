{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "grezar";
    userEmail = "grezar.dev@gmail.com";
    aliases = {
      st = "status";
      ch = "checkout";
      br = "branch";
      delete-merged-branches = "git branch --merged | egrep -v '\*|main|master' | xargs git branch -d";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      github.user = "grezar";
      push.default = "tracking";
      init.defaultBranch = "main";
      rebase.autosquash = true;
    };
  };
}
