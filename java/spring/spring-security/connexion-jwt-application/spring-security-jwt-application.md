## Application Spring-Security et JWT
- application qui permet de g�rer des t�ches
- acc�s via API REST s�curis� d'une mani�re stateless, par Spring-Security en utilisant JWT

## Projet-Spring-Boot

### d�pendances
* spring-boot-starter-data-jpa : mapping objet relationnel
* spring-boot-starter-data-rest : mettre en place facilement API Rest (@RepositoryRestResource)
* spring-boot-starter-security : spring security
* spring-boot-starter-web: on cr�er une application web
* io.jsonwebtoken : impl�mentation de jwt (d�pendances manuelles)

### d�pendance clasique
* spring-boot-devtools : red�marrage serveur
* org.projectlombok :
* spring-boot-starter-test : test unitaire
* spring-security-tests : test unitaire de s�curit�


## Processus d'autentification : deux filtres � mettre en place

### Filtre pour faire l'authentification
```
* JWT Authentication Filter :
* attemptAuthentication() : construit un objet Authentication pour Spring-Security
* chechPassword()
* successfulAuthentication() : construit le token JWT en cas d'authentifiation r�ussit
```

### Filtre pour v�rifier l'authentification / le token
```
* JWT Autorisation Filter :
* filtre qui s'ex�cute pour chaque requ�te (avant d'ex�cuter la requ�te pour avoir les r�sultats)
* v�rifie la validit� du token (token par valeur | on v�rifie la signature du token (contient tout ce qu'il faut pour l'exploiter dans son contexte))
* si ok, spring-security met � jour son contexte : setAuthentication(user)
* si ok, la requete est envoy� au dispatcher-servlet
```

### Register (cr�ation de compte)
* M�thode qui permet de cr�er un user
* Particularit� : cr�er le user/password mais ne pas retourner le password dans le flux JSon de retour.
* Pour cela, sur l'entity on utilise les annatotaions suivantes:
```
	// serialisation : on ne veut pas de mot de passe
	@JsonIgnore
	public String getPassword() {
		return password;
	}

	// deserialisation � la cr�ation
	// on recup�re le mot de passe.
	@JsonSetter
	public void setPassword(String password) {
		this.password = password;
	}
``` 

