# Lines configured by zsh-newuser-install
# HISTFILE=~/.histfile
HISTSIZE=0
SAVEHIST=0

bindkey -e
export KEYTIMEOUT=1


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/marcin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias lg='lazygit'
alias dots=$HOME/dotfiles/scripts/files.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

