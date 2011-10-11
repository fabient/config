#!/bin/sh
#

# detect and lauch tmux
#
tmux has
if [ $? -eq 0 ]; then
        if [ -z "${TMUX}" ]; then
                tmux attach
        fi
else
        tmux new
fi

# path
#
export PATH=${PATH}:~/bin

# misc info
#
export EDITOR=joe
export EMAIL_ADDR="EMAIL"
export PAGER=most

# colors
#
export CLICOLOR="YES"
export LS_COLORS="ExGxFxdxCxDxDxhbadExEx"
export GREP_COLOR="01;32"

# aliases
#
alias grep='grep --colour'
alias egrep='egrep --colour'

# X11
#
if [ -z "${DISPLAY}" ]; then
	export DISPLAY=:0.0
fi

# interactive stuff
#
if [ ! -z "${PS1}" ]; then
	# completion
	#
	loadcompletion()
	{
		FN="/usr/local/${1}"
		if [ -f "${FN}" ]; then
			. "${FN}"
			return 1
		fi
		return 0
	}
	loadcompletion "share/examples/tmux/bash_completion_tmux.sh"
	loadcompletion "share/git-core/contrib/completion/git-completion.bash"
	if [ $? -eq 1 ]; then
		GITPS1='$(__git_ps1 " (%s)")'
	else
		GITPS1=' '
	fi
	loadcompletion "bin/bash_completion.sh"

	# prompt
	#
	export PS1='\W'${GITPS1}'\$ '
	stty erase ^H
	shopt -s checkwinsize
fi
