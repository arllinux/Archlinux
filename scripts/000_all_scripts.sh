#!/bin/bash

boot='ext2'
racine='ext4'
home='ext4'

# Pour le choix du système de fichier sur les partitions
echo '========================================================'
echo '=         Choix de système de fichier proposé          ='
echo '========================================================'
echo ':: Le choix du système de fichier pour /boot est  : '$boot
echo ':: Le choix du système de fichier pour / est      : '$racine
echo ':: Le choix du système de fichier pour /home est  : '$home
echo '========================================================'
echo '=  Choix Ok = Entrée ---  sinon  Ctrl + c pour Quitter ='
read -p '========================================================'

mkfs.$boot /dev/sda1
mkfs.$racine /dev/sda3
mkfs.$home /dev/sda4

# La swap est créée en utilisant mkswap : 
mkswap /dev/sda2

echo ':: Les 4 partitions sont crées ::'
echo ':: /dev/sda1 (/boot) est formaté en : '$boot
echo ':: /dev/sda2 (swap) est formaté en :  swap'
echo ':: /dev/sda3 (/) est formaté en :     '$racine
echo ':: /dev/sda4 (/home) est formaté en : '$home
echo '==================================================='
echo '==================================================='

# Montage des partitions
echo ':: Montage des partitions ::'
mount /dev/sda3 /mnt
swapon /dev/sda2
mkdir /mnt/home && mount /dev/sda4 /mnt/home
mkdir /mnt/boot && mount /dev/sda1 /mnt/boot
echo ':: Les 4 partitions sont montées ::'
echo '==================================================='
echo '= Système de fichiers créés et partitions montées ='
echo '==================================================='
lsblk

# Faire une copie du ficher mirrorlist.
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup

# Décommenter TOUS les miroirs dans mirrorlist.backup.
# Pour se faire, sed s'avère très utile.
sed -s 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
echo '======================================================'
echo ":: Copie du fichier mirrorlist éffectuée ::"
echo ":: Fichier mirrorlist.backup décommenté ::"
echo '======================================================'

# Rankmirrors trouve les 10 meilleurs miroirs
# Il écrit le résultat directement dans /etc/pacman.d/mirrorlist
echo '======================================================'
echo ":: Le test peut durer jusqu'à 5 minutes ::"
echo ":: Soyez patient ! Allez vous faire un café :-) ::"
echo '======================================================'
rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

echo '======================================================'
echo '=  Le fichier /etc/pacman.d/mirrorlist est à jour !  ='
echo '======================================================'


# Installation d'un système de base dans /mnt
pacstrap /mnt base base-devel
echo '======================================================'
echo '=      Le système de base est installé dans /mnt     ='
echo '======================================================'

echo '======================================================'
# Génération du fichier fstab en fonction du montage actuel
genfstab -U -p /mnt >> /mnt/etc/fstab
echo '======================================================'
echo ":: Le fichier /mnt/etc/fstab est à jour ! ::"
echo '======================================================'

exit 0
