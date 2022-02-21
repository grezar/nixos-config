{ config, pkgs, lib, ... }:

{
  imports = [
    ./pkgs
  ];

  home.sessionVariables = {
    EDITOR="nvim";
  };

  home.packages = with pkgs; [
    ghq
    terraform-ls # used by neovim
    jq
    kubectl
  ];
}
