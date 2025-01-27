# .bashrc
source /usr/share/doc/git/contrib/completion/git-prompt.sh # source ~/.git-prompt.sh

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions

alias ls="ls --color"
alias ll="ls -al"
alias cd="cd_with_venv_check"

export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"

#PS1='[$?][\u@\h \w]$(__git_ps1)$ '
PS1='[$?] \u:\w$(__git_ps1)$ '

cd_with_venv_check() {
	builtin cd ${1:+"$@"}
	activate_venv
}

activate_venv() {
	[ -d "./venv/" ] && [ -f "./venv/bin/activate" ] && source ./venv/bin/activate
	return 0
}

venvd() {
	if [ -z "$1" ]; then
		return 1
	else
		source "$1/bin/activate"
	fi
}

jqless() {
	local jqfile=${1:--}
	jq -C . ${jqfile} | less -R
}

jqvim() {
	local jqfile=${1:--}
	jq -M . ${jqfile} | nvim -M -c 'set filetype=json'
}

sum() {
	paste -sd+ | bc
}

export EDITOR=nvim

if command -v tmux>/dev/null; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && tmux new-session -A -s main
fi

export PATH="$PATH:/opt/nvim-linux64/bin"

[ -f ~/.custom.sh ] && source ~/.custom.sh
## Don't put anything below here
