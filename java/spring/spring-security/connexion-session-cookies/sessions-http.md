## Session HTTP
* cr�er apr�s authentification par login/password
* dur�e de vie limit�e
* cookies : contient login/password

### Faille de s�curit�

#### CSRF
* Cross Site Request Forgery
* L'id�e, c'est de forcer une victime � faire une op�ration sans qu'elle le sache en profitant de sa connexion
* La victime, c'est le serveur, car une op�ration d'attaque sur le serveur vuln�rable sera effectu�e.

```
* L'utilisateur est d�j� identifi� et poss�de le cookie JSESSIONID
* ca veut dire quoi : s'il y a une requ�te qui sort de la machine vers le serveur, le serveur va l'accepter
* Le serveur peut recevoir le sessionid alors que la requ�te n'a pas �t� envoy� � partir d'un lien du site.
* Exemple : Mail avec un lien:
	* derri�re le lien : 
		- javascript qui envoie une requ�te http pour faire suppression (avec formulaire cach� qui contient des donn�es)
		- quand on clique on envoit la requ�te qui va aboutir car on est identifi�
		- on force la suppression
		- est-ce que vous avez envoy� votre requ�te � partir d'un lien du site ou � partir d'un lien d'un autre application (mail avec un lien,...)
		- le serveur ne le v�rifie pas
		- le serveur ne sait pas dire de quelle application a envoy� le lien ; le site est vuln�rable ; le serveur v�rifie juste le JSESSIONID
```

* Solution : 

```
* CSRF Synchronizer Token
* demander des confirmations
* verifier le r�f�rent
```

#### XSS
* Cross Site Scripting
* La vitcime ici c'est le client. On ajout du script pour agir au niveau du client.
* Comment prot�ger les visiteurs de votre site pour qu'on ne leur vole pas des informations, qu'on attaque pas leur machine?