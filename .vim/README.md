# Vim configs

current plugins:
- vim-plug (a plugin manager)
- nerd tree (a quick file explorer)
- vim-signature (for displaying marks)
- vim-airline (for the bottom bar)

## vim-plug
[a plugin manager for vim](https://github.com/junegunn/vim-plug). most plugins
can be installed using this manager. either follow the instructions from that
plugin, or try `:PlugInstall [name]` then adding it to the end of `.vimrc`.

occasional updates may be necessary. see `:PlugStatus`. update using
`:PlugUpdate` for plugins and `:PlugUpgrade` for vim-plug itself.

## colorschemes
color schemes are from [this plugin](https://github.com/flazz/vim-colorschemes/).
this install only has `deus.vim`, the best theme. copy files from `colors` (in
the above repo) into `.vim/colors` if you want to experiment with other themes.

**using**
edit the line in `.vimrc` as appropriate

    colorscheme theme-name
    
or inside Vim, use `:colorscheme theme-name`
