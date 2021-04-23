## protocole http

### Définition
* Protocole qui permet de récupérer des documents du serveur
	* récupération de ressources statiques
	* récupération de ressource dynamiques
* permet de soumissioner les formulaires

#### http-1.0
* à chaque récupération de ressource, nécessite une connexion, même pour une page nécessitant le chargement de plusieus ressources.

#### http-1.1
* moyen de garder une même connexion pour plusieurs requêtes

## Requête HTTP

#### Méthodes-HTTP
* GET
* POST
* PUT
* DELETE
* OPTIONS
* HEAD

#### CORS
* Origine autorisés
* Par défaut, le navigateur refuse d'envoyer une requête http à un domaine Y, à partir d'une page récupérée à partir d'un domaine X.
* Avant d'envoyer la requête, il faut savoir si le serveur autorise celà. Pour tester cela:
	* requête OPTION envoyé par le navigateur ; récupération des infos (Origines autorisés)
	* pour une appli REST : config (cross-domaine = *) => j'accepte les requêtes venant de n'import quel domaine)
	
#### Headers
* Méthode: Post /login HTTP/1.1
* host: intra.net
* Accept: application/json
* Content-Type: application/x-www-form-urlencoded
* Cookie: JSESSIONID: C4577232131465456

#### Corps de la requête
* Le corps de le requête se trouve après une ligne vide
* infos transmises en fonction du content-type

## Réponse HTTP

#### En-tête de requête
* HTTP/1.1 200 OK
* Date: Wed, ...
* Server: Apache/1.3.24
* Last-Modified: WEd, ...
* Content-Type: application/JSON
* Content-length: 77
* Set-Cookie: JSESSIONID:C4577232131465456

#### Corps de la requête
* données de la réponse HTTP : HTML / XML / JSON ...

#### Code Status
* Information 1xx
* Succès 2xxx
* Redirection 3xx
* Erreur du client 4xx
* Erreur du serveur 5xx
 
 #### Proxy
 * plus rapide : cache
 * sécurité
 * 502: (Bad gateway) : le proxy n'a pas su intérrogé le serveur web

## Entêtes HTPP
* entêtes génériques (Requête et Réponse)
** Connection **
* indique si la connexion doit rester ouverte
Keep-Alive | close | upgrade

## Session HTTP
* créer après authentification par login/password
* durée de vie limitée
* cookies : contient login/password

### Faille de sécurité

#### CSRF
* Cross Site Request Forgery
* L'idée, c'est de forcer une victime à faire une opération sans qu'elle le sache en profitant de sa connexion
* La victime, c'est le serveur, car une opération d'attaque sur le serveur vulnérable sera effectuée.

```
* L'utilisateur est déjà identifié et possède le cookie JSESSIONID
* ca veut dire quoi : s'il y a une requête qui sort de la machine vers le serveur, le serveur va l'accepter
* Le serveur peut recevoir le sessionid alors que la requête n'a pas été envoyé à partir d'un lien du site.
* Exemple : Mail avec un lien:
	* derrière le lien : 
		- javascript qui envoie une requête http pour faire suppression (avec formulaire caché qui contient des données)
		- quand on clique on envoit la requête qui va aboutir car on est identifié
		- on force la suppression
		- est-ce que vous avez envoyé votre requête à partir d'un lien du site ou à partir d'un lien d'un autre application (mail avec un lien,...)
		- le serveur ne le vérifie pas
		- le serveur ne sait pas dire de quelle application a envoyé le lien ; le site est vulnérable ; le serveur vérifie juste le JSESSIONID
```

* Solution : 

```
* CSRF Synchronizer Token
* demander des confirmations
* verifier le référent
```

#### XSS
* Cross Site Scripting
* La vitcime ici c'est le client. On ajout du script pour agir au niveau du client.
* Comment protéger les visiteurs de votre site pour qu'on ne leur vole pas des informations, qu'on attaque pas leur machine?
