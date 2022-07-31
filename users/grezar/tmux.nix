{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    newSession = true;
    terminal = "xterm-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
    extraConfig = ''
      set -g mouse on
      bind-key -T edit-mode-vi WheelUpPane send-keys -X scroll-up
      bind-key -T edit-mode-vi WheelDownPane send-keys -X scroll-down
    '';
  };
}
