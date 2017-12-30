#!/bin/bash

# 01_mirroirs

# Jean-Pierre Antinoux - Décembre 2017

# Faire une copie du ficher mirrorlist.
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
echo ":: Copie du fichier mirrorlist éffectuée ::"

# Décommenter TOUS les miroirs dans mirrorlist.backup.
# Pour se faire, sed s'avère très utile.
sed -s 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
echo ":: Fichier mirrorlist.backup décommenté ::"

# Rankmirrors trouve les 10 meilleurs miroirs
# Il écrit le résultat directement dans /etc/pacman.d/mirrorlist
echo ":: Si la commande dure plus de 15 secondes ::"
echo ":: Arrêtez-la avec Ctrl + c .............. ::"
rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

echo ":: Le fichier /etc/pacman.d/mirrorlist est à jour ! ::"

exit 0

