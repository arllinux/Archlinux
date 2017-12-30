#!/bin/bash

# 01_mirroirs

# Jean-Pierre Antinoux - Décembre 2017

# Renseigner un nom pour la machine
read -p 'Nom de la machine : (ex : poste1 ou gaston) : ' namecomputer

# Renseigner un nom pour le résau
read -p 'Nom du réseau local : (ex : monreseau ou maison) : ' namereseau

# Inscrire le nom de la machine dans le fichier hostname
echo $namecomputer > /etc/hostname

# Inscrire le nom de la machine et du réseau dans le fichier hosts
echo 127.0.1.1 $namecomputer.$namereseau $namecomputer >> /etc/hosts

# Décommenter la locale "fr_FR.UTF-8 UTF-8" dans le fichier locale.gen
sed -i -e "s/\#fr\_FR.UTF\-8\ UTF\-8/ fr\_FR.UTF\-8\ UTF\-8/g" /etc/locale.gen

# Exécuter la commande locale-gen				
locale-gen

# Inscrire la locale "fr_FR.UTF-8" dans le fichier locale.conf
echo LANG="fr_FR.UTF-8" > /etc/locale.conf

# Pour éviter le messages d'erreur dans la session courante
export LANG=fr_FR.UTF-8

# Indiquez la disposition du clavier dans le fichier vconsole.conf
echo KEYMAP=fr > /etc/vconsole.conf

# Ajout du d�pot pour yaourt
cp /etc/pacman.conf /etc/pacman.conf.backup
cat >> /etc/pacman.conf << _PACMANconf_

[archlinuxfr]
SigLevel = Optional TrustAll
Server = http://repo.archlinux.fr/x86_64

_PACMANconf_

# S�lectionner le fuseau horaire Europe/Paris
read -p 'Fuseau horaire : Europe/Paris ? (o/n) : ' fuseau
	if [ $fuseau = "o" ]
		then
			rm /etc/localtime
			ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
		else
			echo ":: Le fuseau horaire doit être configuré manuellement, désolé...
			::"
		fi
# Ajout du NetworkNanager
#read -p 'Mettre en place le NetworkManager ? (o/n) : ' nm
#	if [ $nm = "o" ]
#		then
#			pacman -S networkmanager
#			systemctl enable NetworkManager.service
#	   	echo ":: Le NetworkNanager est en route ::"
#		else
#		  echo ":: Vous avez choisi de ne pas installeir le NetworkNanager ::"
#	fi

exit 0

