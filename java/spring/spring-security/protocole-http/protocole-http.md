## protocole http

### D�finition
* Protocole qui permet de r�cup�rer des documents du serveur
	* r�cup�ration de ressources statiques
	* r�cup�ration de ressource dynamiques
* permet de soumissioner les formulaires

#### http-1.0
* � chaque r�cup�ration de ressource, n�cessite une connexion, m�me pour une page n�cessitant le chargement de plusieus ressources.

#### http-1.1
* moyen de garder une m�me connexion pour plusieurs requ�tes

## Requ�te HTTP

#### M�thodes-HTTP
* GET
* POST
* PUT
* DELETE
* OPTIONS
* HEAD

#### CORS
* Origine autoris�s
* Par d�faut, le navigateur refuse d'envoyer une requ�te http � un domaine Y, � partir d'une page r�cup�r�e � partir d'un domaine X.
* Avant d'envoyer la requ�te, il faut savoir si le serveur autorise cel�. Pour tester cela:
	* requ�te OPTION envoy� par le navigateur ; r�cup�ration des infos (Origines autoris�s)
	* pour une appli REST : config (cross-domaine = *) => j'accepte les requ�tes venant de n'import quel domaine)
	
#### Headers
* M�thode: Post /login HTTP/1.1
* host: intra.net
* Accept: application/json
* Content-Type: application/x-www-form-urlencoded
* Cookie: JSESSIONID: C4577232131465456

#### Corps de la requ�te
* Le corps de le requ�te se trouve apr�s une ligne vide
* infos transmises en fonction du content-type

## R�ponse HTTP

#### En-t�te de requ�te
* HTTP/1.1 200 OK
* Date: Wed, ...
* Server: Apache/1.3.24
* Last-Modified: WEd, ...
* Content-Type: application/JSON
* Content-length: 77
* Set-Cookie: JSESSIONID:C4577232131465456

#### Corps de la requ�te
* donn�es de la r�ponse HTTP : HTML / XML / JSON ...

#### Code Status
* Information 1xx
* Succ�s 2xxx
* Redirection 3xx
* Erreur du client 4xx
* Erreur du serveur 5xx
 
 #### Proxy
 * plus rapide : cache
 * s�curit�
 * 502: (Bad gateway) : le proxy n'a pas su int�rrog� le serveur web

## Ent�tes HTPP
* ent�tes g�n�riques (Requ�te et R�ponse)
** Connection **
* indique si la connexion doit rester ouverte
Keep-Alive | close | upgrade

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
