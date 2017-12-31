#!/bin/bash

# zcreate.tar.gz.sh

# Jean-Pierre Antinoux - Décembre 2017

CWD=$(pwd)

# Copier les 2 fichiers dans zcompress.
cp $CWD/01_mirroirs.sh $CWD/zcompress
cp $CWD/02_genfstab.sh $CWD/zcompress

# Compresser les 2 fichiers
tar zcvf $CWD/zcompress/scripts.tar.gz zcompress/

# Supprimer les 2 fichiers dans zcompress
rm $CWD/zcompress/*.sh

exit 0
