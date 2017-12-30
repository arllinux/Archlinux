#!/bin/bash

# 01_genfstab

# Jean-Pierre Antinoux - Décembre 2017

genfstab -U -p /mnt >> /mnt/etc/fstab
echo ":: Le fichier /mnt/etc/fstab est à jour ! ::"

exit 0

