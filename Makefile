NVIM_DIR := ~/.config/nvim
TMUX_CONF := ~/.config/tmux/tmux.conf
WEZTERM_CONF := ~/mnt/users/thedo/.wezterm.lua
SETUP := setup_files/
FILE ?= none

setup:
	# Clean up the files
	make clean
	
	# Link all configuration files
	make link

link:
	@echo "Linking nvim directory"
	ln -s $(NVIM_DIR) $(SETUP)/nvim
	@echo "Linking tmux.conf file"
	ln -s $(TMUX_CONF) $(SETUP)/tmux.conf
	@echo "Linking .wezterm.lua file"
	ln -s $(WEZTERM_CONF) $(SETUP)/wezterm.lua

ifeq ($(FILE), none)
update:
	@echo "Please specify a file to update"
	@echo "Format: make update FILE={filename}"
	@echo "Filenames: nvim, tmux, wezterm, or all"
else ifeq ($(FILE), nvim)
update:
	@echo "Updating only nvim"
else ifeq ($(FILE), tmux)
update:
	@echo "Updating only tmux"
else ifeq ($(FILE), wezterm)
update:
	@echo "Updating only wezterm"
else ifeq ($(FILE), all)
update:
	@echo "Updating all files"
else
update:
	@echo "Unknown option: $(FILE)"
	@echo "Options: nvim, tmux, wezterm, or all"
endif

clean:
	@if [ -d $(SETUP)/nvim ]; then \
		echo "Deleting the local nvim_dir"; \
		rm -r $(SETUP)/nvim; \
	fi
	@if [ -f $(SETUP)/tmux.conf ]; then \
		echo "Deleting the local setup_file: tmux.conf"; \
		rm $(SETUP)/tmux.conf; \
	fi
	@if [ -f $(SETUP)/wezterm.lua ]; then \
		echo "Deleting the local setup_file: wezterm.lua"; \
		rm $(SETUP)/wezterm.lua; \
	fi
