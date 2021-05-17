[retour](../exercices.md)

1- Vérifier que docker est correctement installé :
 > docker --version
 > docker run hello-world

2 - télécharger une image linux alpine et lister les répertoir qu'elle contient.
> Docker container run alpine ls -l

3 - télécharger une image linux alpine et afficher avec celle-ci "Hello world" ( 1 seule commandes)
> docker container run alpine echo "hello from alpin

4 - Lancer le fichier caisseAuto.sh a partir du terminal de commande d'un conteneur debian
> docker build -t caisseAuto .
> docker run -it caisseAuto
> ./caisseAuto.sh
> ( pour quitter le terminal de commande : exit)