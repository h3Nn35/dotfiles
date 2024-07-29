#!/bin/bash
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R $USER ./yay
cd yay
makepkg -si
