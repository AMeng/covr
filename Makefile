SHELL := bash

demo_up:
	@ ./docker.sh ./demo_up.sh

demo_down:
	@ ./docker.sh ./demo_down.sh

attach:
	@ ./docker.sh bash
