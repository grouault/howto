# Vocabulairec
* Unstage : désindexer, enelver de l'index, dé-présélectionner
* discard changes : annuler les modifications
* commit : objet de type commit
* blob : objet de type fichier dans le dépôt	
* tree : objet de type arbre dans le dépôt : [arbre de branche]
* snapshot: objet de type arbre dans le dépôt : [arbre de la racine du projet]

## dépôt
* le dépôt est constitué de l'ensembe des objets blob, tree, commit et snapshot.

## index (zone)
* simple fichier texte
* stocke les informations concernant ce qui fera parti du prochain instantané
* zone de préparation

## indexation
1. calcule une empreinte (sha = version) pour chaque fichier à versionner. 
2. stockage de la version de chaque fichier [b=blob] dans le dépôt 
3. ajout l'empreinte à la zone d'index

## commit
1. recalcul de l'arbre de la racine 
* git calcule l'empreinte de chaque sous-répertoire ; objet de type arbre : [t=tree]
* git stocke ces objets de [t=tree] dans le dépôt Git.
2. création d'un objet [c=commit] qui contient des métadonnées + un pointeur vers l'arbre de la racine du projet.
'''

   [c=commit] --> [s=snapshot=instantané du contenu que vous avez indexé]

'''
** metadonnées ** : les noms et prénoms de l'auteur, le message, et des pointeurs vers le ou les commits qui précèdent directement ce commit.
  
## snapshot
* instantané [s=snapshot] du contenu de l'espace de travail au moment [t] 
