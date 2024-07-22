#!/bin/bash

# Funktion, um den Paketmanager zu erkennen
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v yum &> /dev/null; then
        echo "yum"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v zypper &> /dev/null; then
        echo "zypper"
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

# Funktion, um zu prüfen und zu installieren
check_and_install() {
    PACKAGE=$1
    if ! command -v $PACKAGE &> /dev/null; then
        echo "$PACKAGE is not installed. Installing..."
        if [ "$PACKAGE_MANAGER" == "apt" ]; then
            sudo apt update
            sudo apt install -y $PACKAGE
        elif [ "$PACKAGE_MANAGER" == "yum" ]; then
            sudo yum install -y $PACKAGE
        elif [ "$PACKAGE_MANAGER" == "pacman" ]; then
            sudo pacman -Sy --noconfirm $PACKAGE
        elif [ "$PACKAGE_MANAGER" == "dnf" ]; then
            sudo dnf install -y $PACKAGE
        elif [ "$PACKAGE_MANAGER" == "zypper" ]; then
            sudo zypper install -y $PACKAGE
        fi
    else
        echo "$PACKAGE is already installed."
    fi
}

# Erkennung des Paketmanagers
PACKAGE_MANAGER=$(detect_package_manager)
echo "Detected package manager: $PACKAGE_MANAGER"

# Prüfung und Installation von Git und Rust
check_and_install git

if ! command -v rustc &> /dev/null; then
    echo "Rust is not installed. Installing..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
else
    echo "Rust is already installed."
fi

# Rust Programm ausführen
echo "Running Rust program..."
cd /path/to/your/rust/program
cargo run
