SHELL := /bin/sh

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
REPO_ROOT := $(patsubst %/,%,$(dir $(MAKEFILE_PATH)))

.DEFAULT_GOAL := help

.PHONY: help install nvim doom vim tmux zsh git link

help:
	@echo "Usage: make [install|nvim|doom|vim|tmux|zsh|git]"

install: nvim doom vim tmux zsh git

nvim:
	@$(MAKE) --no-print-directory -f "$(MAKEFILE_PATH)" link \
		SOURCE="$(REPO_ROOT)/.config/nvim" \
		TARGET="$(HOME)/.config/nvim"

doom:
	@$(MAKE) --no-print-directory -f "$(MAKEFILE_PATH)" link \
		SOURCE="$(REPO_ROOT)/.config/doom" \
		TARGET="$(HOME)/.config/doom"

vim:
	@$(MAKE) --no-print-directory -f "$(MAKEFILE_PATH)" link \
		SOURCE="$(REPO_ROOT)/.vimrc" \
		TARGET="$(HOME)/.vimrc"
	@$(MAKE) --no-print-directory -f "$(MAKEFILE_PATH)" link \
		SOURCE="$(REPO_ROOT)/.vim/autoload/plug.vim" \
		TARGET="$(HOME)/.vim/autoload/plug.vim"

tmux:
	@$(MAKE) --no-print-directory -f "$(MAKEFILE_PATH)" link \
		SOURCE="$(REPO_ROOT)/.tmux.conf" \
		TARGET="$(HOME)/.tmux.conf"

zsh:
	@$(MAKE) --no-print-directory -f "$(MAKEFILE_PATH)" link \
		SOURCE="$(REPO_ROOT)/.zshrc" \
		TARGET="$(HOME)/.zshrc"

git:
	@$(MAKE) --no-print-directory -f "$(MAKEFILE_PATH)" link \
		SOURCE="$(REPO_ROOT)/.gitconfig" \
		TARGET="$(HOME)/.gitconfig"

link:
	@set -eu; \
	if [ -e "$(TARGET)" ] && [ ! -L "$(TARGET)" ]; then \
		echo "error: $(TARGET) already exists and is not a symlink" >&2; \
		exit 1; \
	fi; \
	mkdir -p "$$(dirname "$(TARGET)")"; \
	ln -sfn "$(SOURCE)" "$(TARGET)"; \
	echo "linked $(TARGET) -> $(SOURCE)"
