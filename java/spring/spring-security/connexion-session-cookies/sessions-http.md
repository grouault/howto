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