config_path=~/.config/
mkfile_path:=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
nvim_path:=$(join $(mkfile_path),nvim/)

.PHONY: setup
setup:
	@mkdir -p $(config_path)
	@ln -s $(nvim_path) $(config_path)
