{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    coc = {
      enable = true;
      settings = ''
        {
        	"languageserver": {
        		"terraform": {
        			"command": "terraform-ls",
        			"args": ["serve"],
        			"filetypes": [
        				"terraform",
        				"tf"
        			],
        			"initializationOptions": {},
        			"settings": {}
        		}
        	}
        }
      '';
    };
    plugins = with pkgs.vimPlugins; [
      nord-vim
      vim-airline
      vim-airline-themes
      vim-polyglot
      vim-over
      vim-trailing-whitespace
      auto-pairs
      vim-nix
      {
        plugin = fzf-vim;
        config = ''
          let mapleader = "\<Space>"
          nnoremap <silent> <Leader>f :GFiles<CR>
          nnoremap <silent> <Leader>g :Files<CR>
          nnoremap <silent> <Leader>b :Buffers<CR>
          nnoremap <silent> <Leader>cs :Commits<CR>
          nnoremap <silent> <Leader>s :Rg<CR>
        '';
      }
      {
        plugin = vim-terraform;
        config = ''
          let g:terraform_align=1
          let g:terraform_fmt_on_save=1
        '';
      }

      {
        plugin = coc-nvim;
        config = ''
          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gy <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)
          nmap <silent> ,fmt <Plug>(coc-format)
        '';
      }
      coc-fzf
      coc-yaml
      coc-json
      coc-html
      {
        plugin = coc-go;
        config = ''
          autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
        '';
      }
      coc-solargraph
      coc-tsserver
      coc-prettier
      coc-eslint
    ];
    extraConfig = ''
      syntax enable
      set background=dark
      colorscheme nord

      set hidden
      set nobackup
      set number
      set cursorline
      set clipboard=unnamedplus

      inoremap <silent> jk <ESC>
      nmap <silent> <Esc><Esc> :noh<CR>
    '';
    extraPackages = with pkgs; [ fzf ];
  };
}
