USER := $(shell whoami)
HOME_DIR := $(shell echo $(HOME))
NVIM_DIR := $(HOME_DIR)/.config/nvim
TMUX_DIR := $(HOME_DIR)/.config/tmux
TMUX_CONF := $(TMUX_DIR)/tmux.conf
WEZTERM_CONF := /mnt/c/Users/thedo/.wezterm.lua
GLAZE_CONF := /mnt/c/Users/thedo/.glzr/glazewm/config.yaml

REPO_ROOT := $(shell pwd)
SETUP_DIR := $(REPO_ROOT)/setup_files
LINK_DIR := $(REPO_ROOT)/linked_files

FILE ?= none

all:
	@echo "make setup: clean all local repo files and place with user's files"
	@echo "make upload: prepare files for GitHub upload"
	@echo "make update FILE={filename}: update specific configuration files"

# Ensure setup directory exists
$(SETUP_DIR):
	mkdir -p $(SETUP_DIR)

upload: clean copy

copy: $(SETUP_DIR)
	@echo "Copying files for GitHub upload..."
	@if [ -d "$(NVIM_DIR)" ]; then \
		echo "Copying nvim configuration..."; \
		cp -r $(NVIM_DIR) $(REPO_ROOT)/; \
	else \
		echo "Warning: $(NVIM_DIR) not found"; \
	fi
	
	@if [ -f "$(TMUX_CONF)" ]; then \
		echo "Copying tmux configuration..."; \
		mkdir -p $(SETUP_DIR); \
		cp $(TMUX_CONF) $(SETUP_DIR)/tmux.conf; \
	else \
		echo "Warning: $(TMUX_CONF) not found"; \
	fi
	
	@if [ -f "$(WEZTERM_CONF)" ]; then \
		echo "Copying wezterm configuration..."; \
		cp $(WEZTERM_CONF) $(SETUP_DIR)/.wezterm.lua; \
	else \
		echo "Warning: $(WEZTERM_CONF) not found"; \
	fi


	@if [ -f "$(GLAZE_CONF)" ]; then \
		echo "Copying glaze config.yaml"; \
		cp $(GLAZE_CONF) $(SETUP_DIR)/config.yaml; \
	else \
		echo "Warning: $(GLAZE_CONF) not found"; \
	fi

setup: clean link

link: $(SETUP_DIR)
	@echo "Creating symbolic links to configuration files..."
	
	@if [ -d "$(NVIM_DIR)" ]; then \
		echo "Linking nvim directory..."; \
		cp -r $(NVIM_DIR) $(REPO_ROOT)/; \
		ln -sf $(REPO_ROOT)/nvim $(SETUP_DIR)/nvim; \
	else \
		echo "Error: $(NVIM_DIR) not found"; \
		exit 1; \
	fi
	
	@if [ -f "$(TMUX_CONF)" ]; then \
		echo "Linking tmux.conf file..."; \
		ln -sf $(TMUX_CONF) $(SETUP_DIR)/tmux.conf; \
	else \
		echo "Error: $(TMUX_CONF) not found"; \
		exit 1; \
	fi
	
	@if [ -f "$(WEZTERM_CONF)" ]; then \
		echo "Linking .wezterm.lua file..."; \
		ln -sf $(WEZTERM_CONF) $(SETUP_DIR)/wezterm.lua; \
	else \
		echo "Error: $(WEZTERM_CONF) not found"; \
		exit 1; \
	fi

	@if [ -f "$(GLAZE_CONF)" ]; then \
		echo "Linking glaze config.yaml"; \
		ln -sf $(GLAZE_CONF) $(SETUP_DIR)/config.yaml; \
	else \
		echo "Error: $(GLAZE_CONF) not found"; \
		exit 1; \
	fi

update:
ifeq ($(FILE), none)
	@echo "Please specify a file to update"
	@echo "Format: make update FILE={filename}"
	@echo "Filenames: nvim, tmux, wezterm, or all"
else ifeq ($(FILE), nvim)
	@echo "Updating only nvim configuration..."
	@if [ -d "$(NVIM_DIR)" ]; then \
		rm -rf $(REPO_ROOT)/nvim; \
		cp -r $(NVIM_DIR) $(REPO_ROOT)/; \
		echo "Nvim configuration updated"; \
	else \
		echo "Error: $(NVIM_DIR) not found"; \
	fi
else ifeq ($(FILE), tmux)
	@echo "Updating only tmux configuration..."
	@if [ -f "$(TMUX_CONF)" ]; then \
		mkdir -p $(SETUP_DIR); \
		cp $(TMUX_CONF) $(SETUP_DIR)/tmux.conf; \
		echo "Tmux configuration updated"; \
	else \
		echo "Error: $(TMUX_CONF) not found"; \
	fi
else ifeq ($(FILE), wezterm)
	@echo "Updating only wezterm configuration..."
	@if [ -f "$(WEZTERM_CONF)" ]; then \
		mkdir -p $(SETUP_DIR); \
		cp $(WEZTERM_CONF) $(SETUP_DIR)/.wezterm.lua; \
		echo "WezTerm configuration updated"; \
	else \
		echo "Error: $(WEZTERM_CONF) not found"; \
	fi
else ifeq ($(FILE), all)
	@make update FILE=nvim
	@make update FILE=tmux
	@make update FILE=wezterm
	@echo "All configurations updated"
else
	@echo "Unknown option: $(FILE)"
	@echo "Options: nvim, tmux, wezterm, or all"
endif

clean:
	@echo "Cleaning repository files..."
	@if [ -d "$(SETUP_DIR)/nvim" ]; then \
		echo "Deleting the repository file nvim directory"; \
		rm -rf $(SETUP_DIR)/nvim; \
	fi
	@if [ -f "$(SETUP_DIR)/tmux.conf" ]; then \
		echo "Deleting the repository file tmux.conf"; \
		rm $(SETUP_DIR)/tmux.conf; \
	fi
	@if [ -f "$(SETUP_DIR)/.wezterm.lua" ]; then \
		echo "Deleting the repository file .wezterm.lua"; \
		rm $(SETUP_DIR)/.wezterm.lua; \
	fi
	@if [ -f "$(SETUP_DIR)/wezterm.lua" ]; then \
		echo "Deleting the repository file wezterm.lua"; \
		rm $(SETUP_DIR)/wezterm.lua; \
	fi
	@if [ -f "$(SETUP_DIR)/config.yaml" ]; then \
		echo "Deleting the repository file config.yaml"; \
		rm $(SETUP_DIR)/config.yaml; \
	fi
