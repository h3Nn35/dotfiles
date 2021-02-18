#!/bin/bash
###########################
# Dieses Skript erstellt Links vom Home Ordner zur jeweiligen Datei im Verzeichnis home/dotfiles
###########################

####### Variablen

dir=~/dotfiles			# dotfiles Ordner
olddir=~/dotfiles_old		# Ordner fuer alte dotfiles als Backup
files="bashrc vimrc zshrc"	# Diese Dateien erhalten den Link

#######

# dotfiles_old im Home Ordner erstellen
echo -n "Erstelle $olddir im Home Ordner um alte dotfiles zu sichern ..."
mkdir -p $olddir
echo "erledigt"

# ins dotfiles Verzeichnis wechseln
echo -n "Ins dotfiles Verzeichnis wechseln ..."
cd $dir
echo "erledigt"

# Alle bestehenden dotfiles in dotfiles_old Verzeichnis verschieben und Links zum Home Ordner f√r alle Dateien im dotfiles Ordner erstellen
for file in $files; do
	echo "Verschiebe alle bestehenden dotfiles vom Home Ordner nach home/dotfiles ..."
	mv ~/.$file ~/dotfiles_old/
	echo "Link zu $file im Home Ordner erstellen ..."
	ln -s $dir/$file ~/.$file
done
