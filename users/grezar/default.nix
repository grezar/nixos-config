{ config, pkgs, lib, ... }:

{
  imports = [
    ./home.nix
    ./alacritty.nix
    ./git.nix
    ./neovim.nix
    ./zsh.nix
    ./tmux.nix
    ./go.nix
    ./i3.nix
  ];
}
