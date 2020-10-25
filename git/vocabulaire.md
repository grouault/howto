# Vocabulairec
* Unstage : d�sindexer, enelver de l'index, d�-pr�s�lectionner
* discard changes : annuler les modifications
* commit : objet de type commit
* blob : objet de type fichier dans le d�p�t	
* tree : objet de type arbre dans le d�p�t : [arbre de branche]
* snapshot: objet de type arbre dans le d�p�t : [arbre de la racine du projet]

## d�p�t
* le d�p�t est constitu� de l'ensembe des objets blob, tree, commit et snapshot.

## index (zone)
* simple fichier texte
* stocke les informations concernant ce qui fera parti du prochain instantan�
* zone de pr�paration

## indexation
1. calcule une empreinte (sha = version) pour chaque fichier � versionner. 
2. stockage de la version de chaque fichier [b=blob] dans le d�p�t 
3. ajout l'empreinte � la zone d'index

## commit
1. recalcul de l'arbre de la racine 
* git calcule l'empreinte de chaque sous-r�pertoire ; objet de type arbre : [t=tree]
* git stocke ces objets de [t=tree] dans le d�p�t Git.
2. cr�ation d'un objet [c=commit] qui contient des m�tadonn�es + un pointeur vers l'arbre de la racine du projet.
'''
	[c=commit] --> [s=snapshot=instantan� du contenu que vous avez index�]
'''
** metadonn�es ** : les noms et pr�noms de l'auteur, le message, et des pointeurs vers le ou les commits qui pr�c�dent directement ce commit.
  
## snapshot
* instantan� [s=snapshot] du contenu de l'espace de travail au moment [t] 