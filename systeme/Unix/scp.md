# Commande scp
##
Scp est une commande pratique pour transf�rer des fichiers d�un serveur � un autre. Elle est bas�e sur l�authentification ssh.
SCP permet donc de transf�rer des fichiers via ssh d�un serveur � un autre, sans forc�ment passer par votre machine locale.

Utilisation pour un fichier local :
-----------------------------------
scp monfichierlocal user@serveur-distant:/home/user/nomfichierdistant2
Cette commande va donc copier monfichierlocal sur le serveur distant dans le dossier /home/user avec le nom monfichierdistant2

Exemple:
scp jakarta-oro-2.0.8.jar root@intradyn://usr/local/was/AppServer/installedApps/ContentServer4StagApp.ear/cs.war/WEB-INF/lib

Copier un fichier distant:
--------------------------
De la m�me fa�on je peux copier un fichier d�un serveur distant sur ma machine locale.
scp user@serveurdistant:/chemin/fichierdistant


##
$ scp caisseAuto.sh grouault@192.168.56.107:/datas/docker

# Exemple :
##
# SCP : r�cup�rer les fichiers depuis webdev
scp was6@webdev.citepro.cite-sciences.fr:/tmp/estim/hook-project/estim-discussion-hook-6.1.1.1.war .
# portail
scp liferay@vm-estim-devlr2:/data/svn-trunk/estim-portail-portlet/estim-portail-portlet/target/estim-portail-portlet-1.0.war .
# annuaire
scp liferay@vm-estim-devlr2:/data/svn-trunk/estim-annuaire-portlet/estim-annuaire-portlet/target/estim-annuaire-portlet-1.0.war .
# ressources
scp liferay@vm-estim-devlr2:/data/svn-trunk/estim-ressources-portlet/estim-ressources-portlet/target/estim-ressources-portlet-1.0.war .
# contacts
scp liferay@vm-estim-devlr2:/data/svn-trunk/estim-contacts-portlet/estim-contacts-portlet/target/estim-contacts-portlet-trunk-SNAPSHOT.war .

##
svn co http://vm-estim-devlr1.citepro.cite-sciences.fr/svn/ESTIM/ESTIM-UTILS/trunk/ estim-utils-lib

## BLO
scp exploit@recblo:/opt/blo/bons_livraisons/modeles/rec/35/recto/Fond5MFD.jpg

scp exploit@recblo:"/opt/blo/bons_livraisons/modeles/rec/35/recto/Fond5MFD\ logo.jpg"
scp exploit@recblo:"'/opt/blo/bons_livraisons/modeles/rec/35/recto/Fond5MFD logo.jpg'"