# Installations
{{{
## Pacman

### Core

pacman -S base base-devel linux linux-firmware linux-headers archlinux-keyring \
grub vim networkmanager git chezmoi man-db man-pages texinfo clang ntp cpupower \
xclip vifm p7zip unzip unrar dosfstools exfatprogs ntfs-3g herbstluftwm \
xorg-server xorg-xinit xorg-xinput xorg-xprop xorg-xset xorg-xsetroot xorg-xrdb \
xorg-xev

### Secondary

pacman -S rofi ueberzug feh htop maim sxiv zathura fzf fontconfig picom \
xdg-user-dirs udisks2

### Supplementary

pacman -S pipewire pipewire-audio pipewire-alsa pipewire-pulse pipewire-jack \
pipewire-docs wireplumber

### Miscellaneous

pacman -S texlive-basic texlive-latex texlive-latexrecommended \
texlive-fontsrecommended firefox steam noto-fonts figlet imagemagick gimp \
inkscape mpv obsidian qbittorrent r vlc libreoffice rustup thunar


## AUR

git clone https://aur.archlinux.org/paru.git; cd paru; makepkg -si
paru -S pandoc-bin mullvad-vpn spotify discord_arch_electron


## System Specific

### Laptop

pacman -S intel-ucode light powertop tlp xf86-video-intel libva-intel-driver \
mesa vulkan-intel bluez bluez-utils bc

### Desktop

pacman -S nvidia nvidia-utils lib32-nvidia-utils
paru -S libva-nvidia-driver


}}}

# Modifications
{{{
## General
- [usermod] add user to storage group
- [fonts] add custom fonts to /usr/share/fonts/
- [texlive] add custom styles to /etc/texmf/tex/local/

## Laptop
- [usermod] add user to video group
- [libinput] configure /etc/X11/xorg.conf.d/30-touchpad.conf

## Desktop
- [nvidia] remove kms from HOOKS in /etc/mkinitcpio.conf
- [nvidia] add kernel modules nvidia nvidia_modeset nvidia_uvm nvidia_drm
- [nvidia] configure /etc/X11/xorg.conf.d/{10-monitor.conf,20-nvidia.conf}
- [numlock] add numlock to HOOKS in /etc/mkinitcpio.conf


}}}
