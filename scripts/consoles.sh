#!/bin/bash
#
# param_consoles.sh
# 
# Jean-Pierre Antinoux - Décembre 2017

CWD=$(pwd)

# Vérification de la syntaxe de l'utilisateur principal
if [ $USER != "root" ]
    then
        echo "Pour exécuter ce script il faut être l'utilisateur root !"
    else
    # Configuration des invites de commandes
    echo ":: Configuration invite de commande pour l'administrateur."
    cat $CWD/../bash/invite_root > /root/.bashrc
    cat $CWD/../bash/.bash_profile > /root/.bash_profile
     
    # Configuration de Vim
    echo ":: Configuration de Vim."
    cat $CWD/../vim/vimrc > /etc/vimrc
    chmod 0644 /etc/vimrc
    echo ":: Réglages de base terminés :"
    
fi

exit 0
