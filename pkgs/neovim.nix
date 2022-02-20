{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nord-vim
      vim-airline
      vim-airline-themes
      vim-polyglot
      vim-over
      vim-trailing-whitespace
      auto-pairs
    ];
    extraConfig = ''
      syntax enable
      set background=light
      colorscheme nord

      set number

      inoremap <silent> jk <ESC>
    '';
  };
}
