# angular/cli ==> commande ng

## installation

### Install Globally
npm install -g @angular/cli

### Install Locally
npm install @angular/cli

### desactive analytics
ng analytics off

### localisation
C:\Users\grouault\AppData\Roaming\npm\node_modules\@angular\cli

## Commande

### créer un projet
ng new name_project

### lancer le serveur
ng serve
lance un serveur http (live reload) : compilation, packaging, écoute (web-socket)

### Création de component

* general
$ ng g component nom_composant

* ng generate component dans dossier components/nav-bar
$ ng g c components/nav-bar 

### Création d'un service
ng g service nomService
=> ne pas oulier de mettre à jour le fichier AppModule et le tableau Providers

### build
ng build
angular compile le front-end et le place dans le folder de sortie:
==> angular-cli.json : outDir
