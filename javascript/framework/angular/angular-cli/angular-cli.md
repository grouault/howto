# angular/cli

[home](../angular.md)

## principe
- télécharge toutes les dépendances requises aux projets
-- compilateur, webpack, ...
-- librairie angular

## structure projet
- e2e : test d'intégration / test end to end
- node_modules : binaires pour compiler et servir le projet
- src : source de l'application
- angular-cli.json: configuration du client angular
- .editorconfig: expliquer à l'éditeur comment de comporter vis à vis du projet
- .gitingore
- karma.conf.js: execution des tests unitaires
- package.json : toutes les dépendances pour exécuter l'appliation
- tsconfig.json : config du compilateur typescript
- tslint.json : toutes les règles de développement que l'on s'impose

## src
index.html : boostraper angular
main.ts : initialise angular vis à vis du navigateur
app : module principale qui constitue l'application
asset : font, image, icone, sons, vidéo
environnement: variable d'environnement (dev / prod)

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
