#!/bin/bash
#
# arch14manager.sh
# 
# Jean-Pierre Antinoux - Décembre 2017

CWD=$(pwd)
# WALXML="/usr/share/gnome-background-properties/"

# Vérification de la syntaxe de l'utilisateur principal
if [ $USER != "root" ]
    then
        echo "Pour exécuter ce script il faut être l'utilisateur root !"
    else
    # Vérification du nom d'utilisateur
    read -p 'Utilisateur (login) à personnaliser : ' nom
    while [ -z $nom ]; do
    echo "Veuillez saisir votre nom"
		read nom
    done
    cat /etc/passwd | grep bash | awk -F ":" '{print $1}' | grep -w $nom > /dev/null
        if [ $? = "0" ]
    then
    
    # Configuration des invites de commandes
    echo ":: Configuration invite de commande pour l'administrateur."
    cat $CWD/../bash/invite_root > /root/.bashrc
    cat $CWD/../bash/.bash_profile > /root/.bash_profile
    
    echo ":: Configuration invite de commande p our l'utilisateur courant."
    cat $CWD/../bash/invite_users > /home/$nom/.bashrc
    
		echo ":: Configuration invite de commande pour les futurs utilisateurs."
    cat $CWD/../bash/invite_users > /etc/skel/.bashrc
    
    # Configuration de Vim
    echo ":: Configuration de Vim."
    cat $CWD/../vim/vimrc > /etc/vimrc
    chmod 0644 /etc/vimrc
    
    # Mise en place du bootsplash
    # echo ":: Mise en place du bootsplash. ::"
    # cp $CWD/../bootsplash/wwl.tga /boot/grub/
   
    # Configurer grub
    # echo ":: Configuration de /etc/default/grub. ::"
    # cp /etc/default/grub /etc/default/grub_old
    # cat $CWD/../grub/etc/default/grub_800x600 > /etc/default/grub
    # update-grub

    # Ranger les fonds d'écran à leur place
    cd /usr/share/backgrounds/xfce/
    wget http://sloteur.free.fr/arllinux/fonds_arllinux.tar.gz
    tar xvzf fonds_arllinux.tar.gz
    rm fonds_arllinux.tar.gz
    chmod 0644 /usr/share/backgrounds/xfce/*.jpg
    chown root:root /usr/share/backgrounds/xfce/*.jpg
    
    # Recharger les informations et mettre à jour
    yes | pacman -Syu
    
    # Suppression et ajout de paquets
    # echo ":: Suppression de paquets. ::"
    # CHOLESTEROL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/cholesterol)
    # yes | pacman -Rsn  $CHOLESTEROL
    
    # Installer les paquets supplémentaires
    echo ":: Ajout de paquets. ::"
    PAQUETS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../pkglists/paquets+)
    pacman -S $PAQUETS

echo ":: Réglages de base terminés ::"
    else
       echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
    fi
fi

exit 0
