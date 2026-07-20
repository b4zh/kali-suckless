#!/bin/sh

# Definiendo el valor de la ruta en donde se clono el repo kali-suckless (ks)
path_ks=$(pwd)

## Cambiando zona horaria
sudo timedatectl set-timezone Europe/Madrid &&

# ---

## Actualizando el sistema
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y

# ---
## Instalando paquetes
st_dep="libghc-x11-xft-dev"
dwm_dep="libx11-xcb-dev libxcb-res0-dev"
dwmblocks_dep="libxcb-util-dev"
programas="htop fastfetch suckless-tools dunst bc pamixer pulsemixer pulseaudio-utils ncal lf translate-shell lsd feh zathura"
sudo apt install $st_dep $dwm_dep $dwmblocks_dep $programas -y && 

# ---

## bash + ble.sh
chsh -s /bin/bash
sudo ln -sf /bin/bash /bin/sh # lo siento posix, tendré que adaptar de mejor manera mis dwmblocks-scripts para ti.
cd $path_ks
cp -fv ./bash-blesh/blerc ~/.blerc
mv -v ~/.bashrc ~/.bashrc.kali.bak && cp -fv ./bash-blesh/bashrc ~/.bashrc
cp -fv ./bash-blesh/git-prompt.sh ~/.git-prompt.sh
mkdir -p ~/pkg/
cd ~/pkg/ && git clone --recursive https://github.com/akinomyoga/ble.sh.git &&
cd ~/pkg/ble.sh/ && make install

## ---

## directorios importantes
cd $path_ks
mkdir -p ~/.config/ && cp -rfv ./config/* ~/.config/
mkdir -p ~/.local/bin/ && cp -fv ./bin/* ~/.local/bin/

## --

## Descargando e Instalando entorno suckless

### st
cd ~/pkg/
git clone https://github.com/b4zh/st-0.9.3.git
cd ~/pkg/st-0.9.3/ && sudo make clean install

### dwm
cd ~/pkg/
git clone https://github.com/b4zh/dwm-6.8.git
cd ~/pkg/dwm-6.8/ && sudo make clean install

### dwmblocks-async
cd ~/pkg/
git clone https://github.com/UtkarshVerma/dwmblocks-async.git
git clone https://github.com/b4zh/dwmblocks-scripts.git
cp -rfv ~/pkg/dwmblocks-scripts/sb-scripts/ ~/.config/dwmblocks/
cp -fv ~/pkg/dwmblocks-scripts/otros-scripts/* ~/.local/bin/
cp -fv ~/pkg/dwmblocks-scripts/config.h ~/pkg/dwmblocks-async/.
cd ~/pkg/dwmblocks-async/ && sudo make clean install

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
sudo systemctl disable lightdm.service
sudo systemctl enable getty@tty1.service

## ---

## Fondo de pantalla


## ---

## .xinitrc
echo "dunst &
setxkbmap es
xrandr -s 1920x1080
dwmblocks &
exec /usr/local/bin/dwm" > .xinitrc
chmod +x .xinitrc

## ---

# Configurando idioma del sistema
sudo bash -c "echo 'LANG=es_ES.UTF-8' > /etc/locale.conf"
sudo bash -c "echo 'KEYMAP=es' > /etc/vconsole.conf"
sudo bash -c "echo 'es_ES.UTF-8 UTF-8' > /etc/locale.gen"
sudo locale-gen
