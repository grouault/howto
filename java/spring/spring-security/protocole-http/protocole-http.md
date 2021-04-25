## protocole http

* [home](../spring-security.md)
* [session-http](../connexion-session-cookies/sessions-http.md)
* [jwt-http](../connexion-jwt/notes-jwt.md)

### D�finition
```
* Protocole qui permet de r�cup�rer des documents du serveur
	* r�cup�ration de ressources statiques
	* r�cup�ration de ressource dynamiques
* permet de soumissioner les formulaires
```

![Fonctionnement](1-protocle-http-fonctoinnement-.PNG)
![Socket](2-protocole-http-fonctionnement.PNG)

[D�finition](0-protocole-http-0.PNG)


#### http-1.0
* � chaque r�cup�ration de ressource, n�cessite une connexion, m�me pour une page n�cessitant le chargement de plusieus ressources.

#### http-1.1
* moyen de garder une m�me connexion pour plusieurs requ�tes


## Requ�te HTTP - M�thodes-HTTP

```
GET | POST | PUT | DELETE | OPTIONS | HEAD
```
![M�thodes](3-protocole-http-methodes.PNG)

#### CORS
```
* Origine autoris�s
* Par d�faut, le navigateur refuse d'envoyer une requ�te http � un domaine Y, � partir d'une page r�cup�r�e � partir d'un domaine X.
* Avant d'envoyer la requ�te, il faut savoir si le serveur autorise cel�. Pour tester cela:
	* requ�te OPTION envoy� par le navigateur ; r�cup�ration des infos (Origines autoris�s)
	* pour une appli REST : config (cross-domaine = *) => j'accepte les requ�tes venant de n'import quel domaine)
```

### Headers Requ�te

```
* M�thode: Post /login HTTP/1.1
* host: intra.net
* Accept: application/json
* Content-Type: application/x-www-form-urlencoded
* Cookie: JSESSIONID: C4577232131465456
````

#### Ent�tes HTPP de requ�te
```
* IMPORTANT : ent�tes g�n�riques ==> valables pour requ�te et r�ponse.
* En-t�te 'Connection' : indique si la connexion doit rester ouverte : Keep-Alive | close | upgrade
```

![en-tete-requete](9-entetes-generiques-request.PNG)

### Corps de la requ�te
```
* Le corps de le requ�te se trouve apr�s une ligne vide
* infos transmises en fonction du content-type
```

##### ex requ�te url-encoded
![req-encoded](4-req-http-POST.url-encoded.PNG)

##### ex requ�te json
![req-json](5-req-http-POST.json.PNG)


## R�ponse HTTP

### En-t�te de r�ponse

```
* HTTP/1.1 200 OK
* Date: Wed, ...
* Server: Apache/1.3.24
* Last-Modified: WEd, ...
* Content-Type: application/JSON
* Content-length: 77
* Set-Cookie: JSESSIONID:C4577232131465456
```

![en-tete-reponse](10-enetes-reponse.PNG)

### Corps de la r�ponse

```
* donn�es de la r�ponse HTTP : HTML / XML / JSON ...
```

### exemple Corps de la r�ponse

![en-tete-reponse](6-rep-http.PNG)

### Code Status de la r�ponse

```
* Information 1xx
* Succ�s 2xxx
* Redirection 3xx
* Erreur du client 4xx
* Erreur du serveur 5xx
```
 
![code-status](7-code-status.PNG) 
 
![code-status](8-code-status.PNG) 
 
## Proxy
* plus rapide : cache
* s�curit�
* 502: (Bad gateway) : le proxy n'a pas su int�rrog� le serveur web




