{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      pbcopy = "xclip";
      pbpaste = "xclip -o";
      g = "cd ~/ghq/$(ghq list | fzf --reverse)";
    };
    initExtra = ''
      bindkey -e
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = ".p10k.zsh";
      }
    ];
  };
}
