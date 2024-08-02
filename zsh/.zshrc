#########################################
#  ____                            _    #
# |  _ \ _ __ ___  _ __ ___  _ __ | |_  #
# | |_) | '__/ _ \| '_ ` _ \| '_ \| __| #
# |  __/| | | (_) | | | | | | |_) | |_  #
# |_|   |_|  \___/|_| |_| |_| .__/ \__| #
#                           |_|         #
#########################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi


########################
#  ______       _ _    #
# |__  (_)_ __ (_) |_  #
#   / /| | '_ \| | __| #
#  / /_| | | | | | |_  #
# /____|_|_| |_|_|\__| #
#                      #
########################

## Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

## Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

## Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


#######################################################################
#  ____                        _              _       _  ___    _     #
# |  _ \ _____      _____ _ __| |_ ___   ___ | |___  / |/ _ \  | | __ #
# | |_) / _ \ \ /\ / / _ \ '__| __/ _ \ / _ \| / __| | | | | | | |/ / #
# |  __/ (_) \ V  V /  __/ |  | || (_) | (_) | \__ \ | | |_| | |   <  #
# |_|   \___/ \_/\_/ \___|_|   \__\___/ \___/|_|___/ |_|\___/  |_|\_\ #
#                                                                     #
#######################################################################

## Add in Powerlevel10k
#zinit ice depth=1; zinit light romkatv/powerlevel10k

## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship



#####################################################
#          _       ____  _             _            #
#  _______| |__   |  _ \| |_   _  __ _(_)_ __  ___  #
# |_  / __| '_ \  | |_) | | | | |/ _` | | '_ \/ __| #
#  / /\__ \ | | | |  __/| | |_| | (_| | | | | \__ \ #
# /___|___/_| |_| |_|   |_|\__,_|\__, |_|_| |_|___/ #
#                                |___/              #
#####################################################

## Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

## Autocomplete
zinit light zsh-users/zsh-completions
autoload -Uz compinit && compinit		# Autocompletion wird beim Start geladen

### Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'		# Autocompletion ist nicht mehr Case sensetive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"		# Farben bei der Autocompletion
zstyle ':completion:*' menu no								# Standard Menü ausschalten
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'	# Vorschau des Ordners bei der Tab Suche

## Auto Suggestions
zinit light zsh-users/zsh-autosuggestions

## fzf TAB
zinit light Aloxaf/fzf-tab


##########################################################
#  _  __          _     _           _ _                  #
# | |/ /___ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___  #
# | ' // _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __| #
# | . \  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \ #
# |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/ #
#           |___/                             |___/      #
##########################################################

## emacs Keybindings
bindkey -e

## History Search
bindkey '^p' history-search-backward	# CTRL + p
bindkey '^n' history-search-forward		# CTRL + n


#####################################
#  _   _ _     _                    #
# | | | (_)___| |_ ___  _ __ _   _  #
# | |_| | / __| __/ _ \| '__| | | | #
# |  _  | \__ \ || (_) | |  | |_| | #
# |_| |_|_|___/\__\___/|_|   \__, | #
#                            |___/  #
#####################################

HISTSIZE=500000					# Anzahl der Einträge in der History
HISTFILE=~/.zsh_history			# Hier wird die History gespeichert
SAVEHIST=$HISTSIZE				# Muss gleich mit der HISTSIZE sein
HISTDUP=erase					# Duplikate in der History werden gelöscht
setopt appendhistory			# Befehle hinten anhängen anstatt zu überschreiben
setopt sharehistory				# Die History wird zwischen den zsh Session geteilt
setopt hist_ignore_space		# Wenn ein Kommando mit einer Leertaste anfängt, geht es nicht in die History (Passwörter etc)
setopt hist_ignore_all_dups		# Duplikate nicht speichern
setopt hist_save_no_dups		# Duplikate nicht speichern
setopt hist_ignore_dups			# Duplikate nicht speichern
setopt hist_find_no_dups		# In der Suche tauchen keine Duplikate auf


##########################################################
#  _   _                        ____                     #
# | | | | ___  _ __ ___   ___  | __ ) _ __ _____      __ #
# | |_| |/ _ \| '_ ` _ \ / _ \ |  _ \| '__/ _ \ \ /\ / / #
# |  _  | (_) | | | | | |  __/ | |_) | | |  __/\ V  V /  #
# |_| |_|\___/|_| |_| |_|\___| |____/|_|  \___| \_/\_/   #
#                                                        #
##########################################################

## Linux
if [ -d /home/linuxbrew ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

## MacOS
if [ -d /opt/homebrew ]; then 
	export PATH=/opt/homebrew/bin:$PATH
fi


############################################################
#  _____                    _____ _           _            #
# |  ___|   _ _________   _|  ___(_)_ __   __| | ___ _ __  #
# | |_ | | | |_  /_  / | | | |_  | | '_ \ / _` |/ _ \ '__| #
# |  _|| |_| |/ / / /| |_| |  _| | | | | | (_| |  __/ |    #
# |_|   \__,_/___/___|\__, |_|   |_|_| |_|\__,_|\___|_|    #
#                     |___/                                #
############################################################

## Shell integrations
if command -v fzf &> /dev/null; then
	eval "$(fzf --zsh)"
fi


##############################################
#   __           _    __      _       _      #
#  / _| __ _ ___| |_ / _| ___| |_ ___| |__   #
# | |_ / _` / __| __| |_ / _ \ __/ __| '_ \  #
# |  _| (_| \__ \ |_|  _|  __/ || (__| | | | #
# |_|  \__,_|___/\__|_|  \___|\__\___|_| |_| #
#                                            #
##############################################

if command -v fastfetch &> /dev/null; then
	fastfetch
elif command -v neofetch &> /dev/null; then
  neofetch
fi

################################
#  _____    _ _ _              #
# | ____|__| (_) |_ ___  _ __  #
# |  _| / _` | | __/ _ \| '__| #
# | |__| (_| | | || (_) | |    #
# |_____\__,_|_|\__\___/|_|    #
#                              #
################################

if command -v nvim &> /dev/null; then
  export VISUAL=nvim
  export EDITOR=nvim
elif command -v vim &> /dev/null; then
  export VISUAL=vim
  export EDITOR=vim
else
  export VISUAL=nano
  export EDITOR=nano
fi


#####################################
#     _    _ _                      #
#    / \  | (_) __ _ ___  ___  ___  #
#   / _ \ | | |/ _` / __|/ _ \/ __| #
#  / ___ \| | | (_| \__ \  __/\__ \ #
# /_/   \_\_|_|\__,_|___/\___||___/ #
#                                   #
#####################################

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

## ---- Eza (better ls) -----
#if command -v eza &> /dev/null; then
#	alias ls="eza --icons=auto --group-directories-first --color=auto -T --level=1 -a"
#else
#	alias ls='ls -AlFhN --color=auto --group-directories-first'
#fi

#alias ls='ls --color'

