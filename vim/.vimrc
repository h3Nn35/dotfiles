"#####################################################
"
" ~/.vimrc
" vim Konfigurationsdatei
"
"#####################################################

"#####################################################
" Eigene Einstellungen
set nu rnu 			" Absolute und relative Zeilennummern an
set cursorline 		" Aktuelle Linie unterstreichen
syntax enable		" Syntax highlighting
set showmatch		" Show matching brackets
set mouse=a			" Mausbenutzung aktivieren
set wrap			" Zeilenumbruch, wenn Text laenger als Bildschirm
set hlsearch		" Suchergebnisse hervorheben
set incsearch		" Zeigt Suchergebnisse während des Suchens an
set ignorecase		" Ignoriert Gross/Kleinschreibung beim Suchen
set autoread		" Liest die Datei neu ein, wenn sie ausserhalb von VIM geaendert wurde
set backup			" Erstellt eine Backup Datei
set tabstop=4		" Tabulator entspricht 4 Leerzeichen
set autoindent		" Automatisch einruecken
set softtabstop=4	" Weicher Tabulator
set shiftwidth=4	" Einruecktiefe
set nocompatible	" VIM-Zusätze aktivieren
" colo elflord

" Make shift-insert work like in Xterm
if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

"#####################################################
" Aus der global uebernommene Einstellungen...Funktion unklar
set backspace=indent,eol,start
set ruler
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set suffixes-=.h
set suffixes-=.obj

" Move temporary files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.cache'
endif
let &g:undodir=&g:directory . '/vim/undo//'
let &g:backupdir=&g:directory . '/vim/backup//'
let &g:directory.='/vim/swap//'
" Create directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif


