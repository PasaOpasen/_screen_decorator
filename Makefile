
SHELL=/bin/bash

test:
	source variables.sh; source screen-decorator.sh; screen -mdS pf bash -c 'while true; do env | grep "^ss"; sleep 1; echo; done'
