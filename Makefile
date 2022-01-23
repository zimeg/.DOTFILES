vim:
	cp .vimrc ${HOME}/.vimrc
	cp -r .vim ${HOME}/.vim
	
	# plugins installed with vim's native package manager
	mkdir -p ~/.vim/pack/git-plugins/start
	git clone --depth 1 https://github.com/dense-analysis/ale.git ${HOME}/.vim/pack/git-plugins/start/ale
	mkdir -p ~/.vim/pack/vim-javascript/start
	git clone https://github.com/pangloss/vim-javascript.git ${HOME}/.vim/pack/vim-javascript/start/vim-javascript
	# remaining plugins will be installed on first open

# removal commands, mostly for development. can be dangerous
# https://twitter.com/zimboboys/status/1485159247461552130
clean-vim:
	rm ${HOME}/.vimrc
	rm -rf ${HOME}/.vim
