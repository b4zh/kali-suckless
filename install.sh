#!/bin/sh

## Cambiando zona horaria
sudo timedatectl set-timezone Europe/Madrid

# ---

## Actualizando el sistema
sudo apt update -y && sudo apt upgrade -y &&
sudo apt autoremove -y

# ---

## Instalando paquetes
st_dep="libghc-x11-xft-dev"
dwm_dep="libx11-xcb-dev libxcb-res0-dev"
programas="gvim htop fastfetch"
sudo apt remove --purge vim
sudo apt install $programas

# ---

## Descargando e Instalando entorno suckless

mkdir -p ~/pkg/

### st
cd ~/pkg/
git clone https://github.com/b4zh/st-0.9.3.git
cd ~/pkg/st-0.9.3/
sudo make clean install

### dwm
cd ~/pkg/
git clone https://github.com/b4zh/dwm-6.8.git
cd ~/pkg/dwm-6.8/
sudo make clean install

# ---

## Instalando la fuente JetBrainsMonoNerdFont
mkdir -p ~/.local/share/fonts/JetBrainsMono/
cd ~/.local/share/fonts/JetBrainsMono/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache

cd ~

## ---

## Estableciendo getty como Gestor de Sesión
sudo systemctl disable ligthdm.service
sudo systemctl enable getty@tty1.service

## .xinitrc

echo "setxkbmap es
xrandr -s 1920x1080
exec /usr/local/bin/dwm" > .xinitrc
chmod +x .xinitrc

# Configurando idioma del sistema
sudo bash -c "echo 'LANG=es_ES.UTF-8' > /etc/locale.conf"
sudo bash -c "echo 'KEYMAP=es' > /etc/vconsole.conf"
sudo bash -c "echo 'es_ES.UTF-8 UTF-8' > /etc/locale.gen"
sudo locale-gen
