#!/bin/bash
#if [ ! command -v yay &> /dev/null ]; then
  cd /opt
  sudo git clone https://aur.archlinux.org/yay.git
  sudo chown -R christian ./yay
  cd yay
  makepkg -si
#else
#  echo "yay ist bereits installiert"
#fi
