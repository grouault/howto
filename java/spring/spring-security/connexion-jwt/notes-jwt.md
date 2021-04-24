## JWT

### D�finition
```
* standard qui d�finit une solution compacte et autonome pour transmettre de mani�re s�curis�e des infos 
	entre les applications en tant qu'objet structur� au format JSon. 
	* compacte : r�duite par sa structure
	* autonome : Token g�n�r� sur la base d'un secret : qui contient toutes les infos d'identifiation de l'utilisateur
* Le secret n'est connu que de la partie back-end qui g�n�re le token	
* cette information peut �tre v�rifi�e et fiable car elle est sign�e num�riquement
```

### Structure
* 3 parties s�par�s par un point : 
	* header
	* payload
	* signature

#### headers
* L'en-t�te se compose de deux parties : le type et l'algorithme de hashage 

#### payload

```

* contient les claims : revendications, informations
* d�clarations concernant : une entit� (g�n�ralement utilisateur) et m�tadonn�es suppl�mentaires
* 3 types de claims : enregistr�es, publiques et priv�es

* claims enregistr�es : recommand�es pour �tre reconnaissable au niveau de chaque application

	* iss : (issuer) celui qui a cr�� le token
	* exp: heure d'expiration
	* sub: sujet, en general au stocke le username
	* aud: audience - public cible - ex: web, front-end, mobile
	* iat: (issued at) date de creation du token
	* jti: JWT ID identifiant unique du token
	* name: peut servir pour stocker le username et afficher au niveau application
	* roles: roles du user

* claims publiques : permet d'enregistrer d'autres claims qui doivent �tre d�finies dans un annuaire des jetons

* claims priv�es: claims personnalis�s, ne rentre pas dans l'interop�rabilit� mais ne concerne que mes applications

```

#### signature :

```
* partie la plus importante
* v�rifier que l'exp�diteur du jwt est celui qu'il pr�tend �tre
* s'assurer que le message n'a pas �t� modifi� en cours de route
* La v�rification se fait c�t� back-end de mani�re g�n�rale
* Signature cr�� de la fa�on suivante:
	HMACSHA256(base64UrlEncode(header) + "." + base64UrlEncode(payload), secret)
	secret : connu seul de la partie-back-end
```

* Transmission:
	* Le token est souvent transmis avec un prefixe au serveur : 
	```
	Authorisation: Bearer H.P.S - Bearer = Porteur
	```
	* Le serveur sait qu'il r�cup�re un pr�fixe mais n'en tient pas compte, il le supprime puis r�cup�re le token

### Avantage

```
* Pas besoin de cache partag� ou distribu�. 
* Chaque serveur d'application doit juste conna�tre le secret et donc le s�curis�.
* Id�e pour la s�curit� : pass� par cl� publique, qui permet de v�rifier la validit� du token.
```

### Stockage 

#### LocalStorage vs SessionStorage

```
* localStorage: partag� par toutes les instances du navigateur ; n'importe quelle application peut-lire le localstorage
* sessionStorage: � chaque fois qu'on ouvre une fen�tre du navigateur, cr�ation d'un session storage ; d�s qu'on ferme une fen�tre, il dispara�t.
Dans ce cas: 
* prot�ge contre les attaques CSRF car jwt n'est pas stock� dans les cookies, donc pas envoy� � partir d'un lien truqu�.
* pas de protection contre la faille XSS ; un script qui arrive vers le navigateur a le droit de lire le localstorage
```

#### Cookies

```
* pas besoin d'�crire du code JavaScript pour envoyer le JWT
* protection XSS : utiliser le flag HttpOnly (JavaScript n'a pas le droit de lire ce cookie) et Secure (ne peut �tre envoyer que par https)
* expose aux attaques CSRF
```

### comment prot�ger CSRF - A revoir ???

```
* token est dans les cookies
* utiliser le synchronizer token ; g�n�re � chaque fois que le serveur envoie la r�ponse, dans le payload du JWT
* envoy� vers l'utilisateur en signant le token et en envoyant le token synchronizer avec la bonne signature
* si le token envoy� ne contient pas le CSRF ou pas le bon ; ne collera pas avec la signature
```

### Autres usages JWT

```
* Formulaires en plusieurs parties : donn�es stock�es dans le token

* Confirmation des emails :
	* Anciennement
		* on cr�e une valeur secr�te que l'on stocke en base
		* on envoit un lien qui contient cette valeur 
		* on demande � l'utilisateur de cliquer sur le lien et on v�rifier la valeur avec la valeur en base
	* JWT
		* on cr�e un token qui contient la valeur et qui est sign� avec la valeur
		* on g�n�re un lien avec le token (dur�e de vie limit��)
		* on demande � l'utilisateur de cliquer sur le lien et on v�rifie le token
```


