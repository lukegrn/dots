zstyle :compinstall filename '/home/lgreen/.zshrc'

autoload -Uz compinit
compinit

autoload -U colors && colors

autoload -Uz vcs_info
precmd() { vcs_info }

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# Prompt config

zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:git:*' formats ' (%F{yellow}%b%f)%m%u%c'
zstyle ':vcs_info:git:*' actionformats ' (%F{yellow}%b[%a]%f%m%u%c)'
zstyle ':vcs_info:*' check-for-changes true

# add untracked files to unstagedstr
# based on: https://github.com/zsh-users/zsh/blob/f9e9dce5443f323b340303596406f9d3ce11d23a/Misc/vcs_info-examples#L155-L170
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[misc]+='%F{magenta}^%f'
    fi
}

setopt PROMPT_SUBST
PROMPT='[$?] %n:%~${vcs_info_msg_0_}$ '

# Misc env vars
export EDITOR=nvim

# Helpful functions
jqless() {
	local jqfile=${1:--}
	jq -C . ${jqfile} | less -R
}

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

# Aliases

alias ls="ls --color"
alias ll="ls -al"
alias cd="cd_with_venv_check"

# Auto start tmux everywhere except vscode
tmux_auto() {
	# Don't launch tmux in vscode terminals
	parent=$(ps -p $PPID -o comm=)
	if [[ "$parent" != "code" ]]; then
		if command -v tmux >/dev/null; then
			[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && tmux new-session -A -s main
		fi
	fi
}

tmux_auto

# Machine specific conf in ~/.custom.sh
[ -f ~/.custom.sh ] && source ~/.custom.sh
