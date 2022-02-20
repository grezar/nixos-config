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
  ];
}
