# https://github.com/neovim/neovim
{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp # https://github.com/hrsh7th/cmp-nvim-lsp
      conform-nvim # https://github.com/stevearc/conform.nvim
      melange-nvim # https://github.com/savq/melange-nvim
      nvim-cmp # https://github.com/hrsh7th/nvim-cmp
      nvim-lspconfig # https://github.com/neovim/nvim-lspconfig
      nvim-jdtls # https://github.com/mfussenegger/nvim-jdtls
      telescope-fzf-native-nvim # https://github.com/nvim-telescope/telescope-fzf-native.nvim
      telescope-nvim # https://github.com/nvim-telescope/telescope.nvim
      undotree # https://github.com/mbbill/undotree
      vim-fugitive # https://github.com/tpope/vim-fugitive
      vim-gitgutter # https://github.com/airblade/vim-gitgutter
      vim-obsession # https://github.com/tpope/vim-obsession
      vim-signature # https://github.com/kshenoy/vim-signature
      config.nur.repos.zimeg.proximity-nvim # https://github.com/zimeg/proximity.nvim
      # https://github.com/tree-sitter/tree-sitter
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
        with plugins; [
          astro # https://github.com/virchau13/tree-sitter-astro
          bash # https://github.com/tree-sitter/tree-sitter-bash
          c # https://github.com/tree-sitter/tree-sitter-c
          css # https://github.com/tree-sitter/tree-sitter-css
          csv # https://github.com/amaanq/tree-sitter-csv
          cuda # https://github.com/theHamsta/tree-sitter-cuda
          diff # https://github.com/the-mikedavis/tree-sitter-diff
          dockerfile # https://github.com/camdencheek/tree-sitter-dockerfile
          git_config # https://github.com/the-mikedavis/tree-sitter-git-config
          git_rebase # https://github.com/the-mikedavis/tree-sitter-git-rebase
          gitattributes # https://github.com/ObserverOfTime/tree-sitter-gitattributes
          gitcommit # https://github.com/gbprod/tree-sitter-gitcommit
          gitignore # https://github.com/shunsambongi/tree-sitter-gitignore
          go # https://github.com/tree-sitter/tree-sitter-go
          gomod # https://github.com/camdencheek/tree-sitter-go-mod
          gosum # https://github.com/amaanq/tree-sitter-go-sum
          gowork # https://github.com/omertuc/tree-sitter-go-work
          gotmpl # https://github.com/ngalaiko/tree-sitter-go-template
          groovy # https://github.com/murtaza64/tree-sitter-groovy
          hack # https://github.com/slackhq/tree-sitter-hack
          hcl # https://github.com/tree-sitter-grammars/tree-sitter-hcl
          html # https://github.com/tree-sitter/tree-sitter-html
          http # https://github.com/rest-nvim/tree-sitter-http
          java # https://github.com/tree-sitter/tree-sitter-java
          javascript # https://github.com/tree-sitter/tree-sitter-javascript
          jq # https://github.com/flurie/tree-sitter-jq
          jsdoc # https://github.com/tree-sitter/tree-sitter-jsdoc
          json # https://github.com/tree-sitter/tree-sitter-json
          jsonc # https://gitlab.com/WhyNotHugo/tree-sitter-jsonc.git
          lua # https://github.com/MunifTanjim/tree-sitter-lua
          luadoc # https://github.com/amaanq/tree-sitter-luadoc
          make # https://github.com/alemuller/tree-sitter-make
          markdown # https://github.com/MDeiml/tree-sitter-markdown
          nix # https://github.com/cstrahan/tree-sitter-nix
          php # https://github.com/tree-sitter/tree-sitter-php
          pymanifest # https://github.com/ObserverOfTime/tree-sitter-pymanifest
          python # https://github.com/tree-sitter/tree-sitter-python
          regex # https://github.com/tree-sitter/tree-sitter-regex
          rust # https://github.com/tree-sitter/tree-sitter-rust
          sql # https://github.com/derekstride/tree-sitter-sql
          ssh_config # https://github.com/ObserverOfTime/tree-sitter-ssh-config
          terraform # https://github.com/MichaHoffmann/tree-sitter-hcl
          tmux # https://github.com/Freed-Wu/tree-sitter-tmux
          toml # https://github.com/tree-sitter-grammars/tree-sitter-toml
          tsx # https://github.com/tree-sitter/tree-sitter-typescript
          typescript # https://github.com/tree-sitter/tree-sitter-typescript
          vhs # https://github.com/charmbracelet/tree-sitter-vhs
          vim # https://github.com/neovim/tree-sitter-vim
          vimdoc # https://github.com/neovim/tree-sitter-vimdoc
          xml # https://github.com/tree-sitter-grammars/tree-sitter-xml
          yaml # https://github.com/tree-sitter-grammars/tree-sitter-yaml
        ]))
      nvim-treesitter-context # https://github.com/nvim-treesitter/nvim-treesitter-context 
    ];
  };
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
