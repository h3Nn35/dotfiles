# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"

source $ZSH/oh-my-zsh.sh

source ~/powerlevel10k/powerlevel10k.zsh-theme

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PATH=/opt/homebrew/bin:$PATH

# Aliases
	alias ls='eza -lAhF --group-directories-first --color=auto'
    alias ll='ls -AhlF --color=auto'
    alias la='ls -AhlF --color=auto'
    alias l='ls -CF'
    alias grep='grep --color=auto'
	alias cp='cp -v'
	alias rm='rm -v'
	alias mkdir='mkdir -v'
	alias cat='bat'

# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# ---- Eza (better ls) -----
alias ls="eza --icons=auto --group-directories-first --color=auto -T --level=1 -a"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

neofetch
