config_path=~/.config/
mkfile_path:=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
nvim_path:=$(join $(mkfile_path),nvim/)

.PHONY: setup-vim-conf
setup-vim-conf:
	mkdir -p $(config_path)
	ln -s $(nvim_path) $(config_path)

.PHONY: setup-packer
setup-packer:
	git clone --depth 1 https://github.com/wbthomason/packer.nvim\
	 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
