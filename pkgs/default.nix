{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./neovim.nix
    ./zsh.nix
  ];
}

