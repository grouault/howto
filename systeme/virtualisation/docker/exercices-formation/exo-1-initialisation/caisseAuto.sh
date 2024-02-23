#!/bin/bash

#Déclaration des variables
#Tableau contenant le nom des articles disponibles
tabArticles=(	'coca '
							'fanta'
							'oasis')
#Tableau contenant le prix des articles disponibles : le prix à l'index i correspond à l'article au même index
tabPrix=(2 1 1)
#Tableau contenant le nombre d'achats des clients : le nombre à l'index i correspond à l'article au même index
nbAchats=(0 0 0)
#Booléen pour la condition de sortie du programme
continueAchats=true

#Fonction passageEnCaisse : boucle principale : tant que l'utilisateur choisit des articles on continue
# 	Si l'utilisateur tape 'q' on donne la facture (appel de la fonction affiche) et quitte le programme

passageEnCaisse()
{
while $continueAchats
do
	echo "Quel article voulez-vous acheter ? ('q' pour imprimer le ticket et quitter)"
	echo "Articles disponibles :"
	echo "Tapez 0 pour ${tabArticles[0]}"
	echo "Tapez 1 pour ${tabArticles[1]}"
	echo "Tapez 2 pour ${tabArticles[2]}"
	read answer
	#switch case
	case $answer in
		[0]|[1]|[2])
			let nbAchats[$answer]=nbAchats[$answer]+1
			;;
		#condition de sortie de la boucle
		"q")
			continueAchats=false
			;;
		*)
			echo "Pb de choix"
			;;
	esac
	#Bonus : effacez l'affichage à chaque passage
	#clear
done
}

passageEnCaisse
#fonction d'affichage
affiche()
{
	let prixFinal="0"
	let conditionArret="${#tabArticles[@]}-1"
	echo "___________________________________________________"
	echo "     Semifir Market                                "
	echo "                                                   "
	echo "                Ticket de Caisse                   "
	echo "___________________________________________________"
	for i in `seq 0 $conditionArret`
	do
		if [[ ! ${nbAchats[$i]} -eq 0 ]]
		let "prixTotal=${tabPrix[$i]}*${nbAchats[$i]}"
		let "prixFinal+=prixTotal"
		then echo "${tabArticles[$i]} | Quantité : ${nbAchats[$i]}  | Prix total : $prixTotal€."
		fi
	done
	echo "___________________________________________________"
	echo "Total : $prixFinal€."
	echo "___________________________________________________"
	echo "                  A Bientôt !"
	echo "___________________________________________________"
#echo ${#tabArticles[@]}
}

#Attention à bien déclarer la fonction AVANT de l'utiliser
affiche
