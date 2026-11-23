.PHONY: all
all: help

.PHONY: help
help:
	@echo 'usage: you must inform which command you want to run.'
	@echo 'usage: read the Makefile and see the commands available.'

.PHONY: link stow
link stow:
	@stow -R */
	@echo 'status: updated all symlinks'
