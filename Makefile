.PHONY: test
SHELL := bash

up:
	@ ./docker.sh ./demo_up.sh

down:
	@ ./docker.sh ./demo_down.sh

attach:
	@ ./docker.sh bash
