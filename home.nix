{ config, pkgs, lib, ... }:

{
  home.sessionVariables = {
    EDITOR="nvim";
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      pbcopy = "xclip";
      pbpaste = "xclip -o";
    };
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

  programs.git = {
    enable = true;
    userName = "grezar";
    userEmail = "grezar.dev@gmail.com";
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

  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 18.0;
      };
    };
  };

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
