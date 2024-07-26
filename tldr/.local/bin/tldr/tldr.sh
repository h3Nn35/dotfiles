#!/bin/bash

# Überprüfen, ob mindestens ein Argument übergeben wurde
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 [-f] <query>"
    exit 1
fi

# Variablen initialisieren
full_output=false
query=""

# Argumente überprüfen und zuweisen
if [ "$1" == "-f" ]; then
    full_output=true
    query=$2
elif [ "$2" == "-f" ]; then
    full_output=true
    query=$1
else
    query=$1
fi

# Überprüfen, ob das query-Argument leer ist
if [ -z "$query" ]; then
    echo "Usage: $0 [-f] <query>"
    exit 1
fi

# curl-Abfrage ausführen und Ergebnis speichern
response=$(curl -s cheat.sh/$query)

# Wenn -f als Parameter übergeben wurde, die gesamte Antwort ausgeben
if [ "$full_output" = true ]; then
    echo "$response"
else
    # Überprüfen, ob "tldr:" in der Antwort enthalten ist
    if echo "$response" | grep -q "tldr:"; then
        # Den Teil ab "tldr:" ausgeben
        echo "$response" | awk '/tldr:/ {flag=1} flag'
    else
        # Die gesamte Antwort ausgeben
        echo "$response"
    fi
fi

