# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/christian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

if command -v fastfetch &> /dev/null; then
	fastfetch
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# Funktion to transform apt to nala, if nala is installed
if command -v nala &> /dev/null; then
	apt() {
		command nala "$@"
	}
	sudo() {
		if [ "$1" = "apt" ]; then
			shift
			command sudo nala "$@"
		else
			command sudo "$@"
		fi
	}
fi
