.PHONY: all help link stow

all: help

help:
	@echo 'usage: you must inform which command you want to run.'
	@echo 'usage: read the Makefile and see the commands available.'

link stow:
	stow -vR */
