#!/bin/bash
#
# 05_create_user.sh
# 
# Jean-Pierre Antinoux - Décembre 2017


# Vérification de la syntaxe de l'utilisateur principal
if [ $USER != "root" ]
    then
        echo "Pour exécuter ce script il faut être l'utilisateur root !"
    else
    # Création d'un utilisateur
    read -p 'Utilisateur (login) à créer : ' nom
    while [ -z $nom ]; do
    echo "Veuillez saisir votre nom"
    read nom
    	done
    
    # Création du nom et avec le groupe users
    echo ":: Création du nom ::"
		useradd -g users -G users -m $nom
   
		# Création du mot de passe
		echo ":: Création du mot de passe ::"
		passwd $nom

		# Ajouter les groupes courant
		echo ":: Ajout de groupes courant ::"
		usermod -aG audio,log,lp,optical,scanner,storage,video $nom
    
		# Affichag des groupes créés
		echo ":: Liste des groupes de $nom ::"
		groups $nom
fi

exit 0
