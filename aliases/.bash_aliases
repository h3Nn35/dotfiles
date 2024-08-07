# Aliase
    # History
        alias h='history'
        export HISTSIZE=10000
        export HISTFILESIZE=10000
        shopt -s histappend
        export HISTTIMEFORMAT="%d %h %H:%M:%S "

    # Bildschirm leeren
    	alias c='clear'

    # Kopieren / Verschieben
        alias cp='cp -v'
		alias mv='mv -v'
		alias sucp='sudo cp -v'
		alias smv='sudo mv -v'

    # Löschen
        alias rm='rm -v'
        alias srm='sudo rm -v'
        alias rmdir='rmdir -rv'
        alias srmdir='sudo rmdir -rv'

    # Ordner erstellen
        alias mkdir='mkdir -pv'
        alias smkdir='sudo mkdir -pv'

    # Programme mit sudo starten
        alias svim='sudo vim'
        alias snano='sudo nano'
        alias smc='sudo mc'

    # Rechte bearbeiten
        alias chmod='chmod -v'
        alias chown='chown -v'

    # Beenden
        alias beenden='sudo shutdown -h now'
        #alias beenden='bash ~/.beenden'

    # apt zu IPv4 zwingen
        #alias apt4='sudo apt update -o Acquire::ForceIPv4=true'

    # Farben hinzufügen
        alias dir='dir -hN --color=auto --group-directories-first'
        alias dirl='dir -AlF --color=auto --group-directories-first'
        alias dira='dir -AhN --color=auto --group-directories-first'
		alias ll='ls'
		alias la='ls'
        # alias ll='ls -AlFh --color=auto --group-directories-first'
        # alias la='ls -AhN --color=auto --group-directories-first'
		alias l='ls -CF'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'

	# Bat anstelle von cat nutzen
		if command -v bat &> /dev/null; then
			alias cat='bat'
		else
			# Ubuntu spezial
			if command -v batcat &> /dev/null; then
				alias cat='batcat'
			fi
		fi
		
    # Wake On LAN	
		alias wol="./wol.sh"

	# ---- Eza (better ls) -----
		if command -v eza &> /dev/null; then
			alias ls="eza --icons=auto --group-directories-first --color=auto -T --level=1 -a"
		else	
			alias ls='ls -AlFhN --color=auto --group-directories-first'
		fi
	# Eigenes TLDR überprüfen und Alias einbinden
	#	if [ -f ~/.local/bin/tldr/tldr.sh


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

	# easy cd
		alias ..='cd ..'

  	# git push vereinfachen
		if command -v git &> /dev/null; then
			alias push='git add . && git commit -m "No commit text" && git push'
		fi
