#!/bin/bash

# 04_bootloader.sh

# Jean-Pierre Antinoux - Décembre 2017

# Parametrage de GRUB
grub-install --target=i386-pc --no-floppy --recheck /dev/sda
echo ":: Mise en place de Grub éffectuée ::"

# Configuration de GRUB
grub-mkconfig -o /boot/grub/grub.cfg
echo ":: Configuration de Grub éffectuée ::"

exit 0

