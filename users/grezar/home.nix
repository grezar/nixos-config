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

  programs.home-manager = {
    enable = true;
  };

  home.stateVersion = "22.05";
  home.username = "makita.riki";
  home.homeDirectory = "/Users/makita.riki";

  home.sessionVariables = {
    EDITOR="nvim";
  };

  home.packages = with pkgs; [
    feh
    ghq
    terraform-ls # used by neovim
    jq
    kubectl
    kubernetes-helm
    telepresence2
    awscli2
    kubie
    circleci-cli
    kubebuilder
    kind
    conftest
    terraform
    gh
    ruby
    docker-compose
    kustomize
    nodejs-18_x
    autoconf
    automake
    circleci-cli
    bc
    ripgrep
    fzf
  ] ++ (with nodePackages;[
    typescript
    yarn
  ]);
}
