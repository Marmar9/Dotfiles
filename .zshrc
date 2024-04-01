# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/marcin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# My lines
eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/ssh-keys/marcin > /dev/null 2>&1

eval "$(starship init zsh)"
