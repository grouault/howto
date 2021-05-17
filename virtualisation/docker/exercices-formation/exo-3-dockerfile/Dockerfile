FROM node
#Recuperation de l'image officiel node comme base

# Nous créons un répertoire pour contenir le code de l'application dans l'image. Ce sera le répertoire de travail de votre application:
WORKDIR /usr/src/app

#On copie les fichier dont on a besoin a l'intérieur de notre images
COPY package*.json ./

#On installe toutes les dépendances
RUN npm install

# On récupère notre fichier index.js
COPY index.js ./

# On indique au daemon docker que l'on veux lancer notre docker sur le port 80808
EXPOSE 8080

#On lance la commande npm start pour démarrer notre application node
CMD [ "npm","start" ]