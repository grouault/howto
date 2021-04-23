## Application Spring-Security et JWT
- application qui permet de gérer des tâches
- accès via API REST sécurisé d'une manière stateless, par Spring-Security en utilisant JWT

## Projet-Spring-Boot

### dépendances
* spring-boot-starter-data-jpa : mapping objet relationnel
* spring-boot-starter-data-rest : mettre en place facilement API Rest (@RepositoryRestResource)
* spring-boot-starter-security : spring security
* spring-boot-starter-web: on créer une application web
* io.jsonwebtoken : implémentation de jwt (dépendances manuelles)

### dépendance clasique
* spring-boot-devtools : redémarrage serveur
* org.projectlombok :
* spring-boot-starter-test : test unitaire
* spring-security-tests : test unitaire de sécurité


## Processus d'autentification : deux filtres à mettre en place

### Filtre pour faire l'authentification
```
* JWT Authentication Filter :
* attemptAuthentication() : construit un objet Authentication pour Spring-Security
* chechPassword()
* successfulAuthentication() : construit le token JWT en cas d'authentifiation réussit
```

### Filtre pour vérifier l'authentification / le token
```
* JWT Autorisation Filter :
* filtre qui s'exécute pour chaque requête (avant d'exécuter la requête pour avoir les résultats)
* vérifie la validité du token (token par valeur | on vérifie la signature du token (contient tout ce qu'il faut pour l'exploiter dans son contexte))
* si ok, spring-security met à jour son contexte : setAuthentication(user)
* si ok, la requete est envoyé au dispatcher-servlet
```

### Register (création de compte)
* Méthode qui permet de créer un user
* Particularité : créer le user/password mais ne pas retourner le password dans le flux JSon de retour.
* Pour cela, sur l'entity on utilise les annatotaions suivantes:
```
	// serialisation : on ne veut pas de mot de passe
	@JsonIgnore
	public String getPassword() {
		return password;
	}

	// deserialisation à la création
	// on recupère le mot de passe.
	@JsonSetter
	public void setPassword(String password) {
		this.password = password;
	}
``` 

