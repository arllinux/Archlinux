#!/bin/bash
#
# 05_wallpaper.sh
# 
# Jean-Pierre Antinoux - Décembre 2017

WALP="/usr/share/backgrounds/xfce"

# Vérification de la syntaxe de l'utilisateur principal
if [ $USER != "root" ]
    then
        echo "Pour exécuter ce script il faut être l'utilisateur root !"
    else
    # Ranger les fonds d'écran à leur place
    cd $WALP
    wget http://sloteur.free.fr/arllinux/fonds_arllinux.tar.gz
    tar xvzf fonds_arllinux.tar.gz
    rm fonds_arllinux.tar.gz
    chmod 0644 $WALP/*.jpg
    chown root:root $WALP/*.jpg
fi

exit 0
