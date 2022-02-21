{ config, pkgs, lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./neovim.nix
    ./zsh.nix
    ./tmux.nix
    ./go.nix
  ];

  home.sessionVariables = {
    EDITOR="nvim";
  };

  home.packages = with pkgs; [
    ghq
    terraform-ls # used by neovim
    jq
    kubectl
    kubernetes-helm
  ];
}
