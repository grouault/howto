# Maven : accès aux fichier de test en tant que Ressource

## Récupération dans le classPath

### src/test/ressources
````
* ce folder permet de stocker toutes les données de test et d'y accéder à l'exécution du test via le Classpath.
* les fichiers de ce folder seront exclus du binaire final
* à utiliser autant que possible:
	* java.io.InputStream
	* java.net.URL
	* java.nio.file
````

```
* Accès via maven
InputStream is = getClass.getRessouceAsStream("test.list");
```

### BaseDir 
Le répertoire courant n'est pas forcément la racine du projet.
Maven fournit la variable système basedir qui pointe à la racine du projet.
```
// définit le chemin absolu du projet sur la machine.
File basedir = new File(System.getProperty("basedir", "")).getAbsoluteFile();
```

#### File et basedir
* Créer un fichier
```
// pour l'utiliser ensuite
// 1- Définir les fichiers en relatif par rapport à la racine du projet.
String relatifRessouceFolder = "\\src\\test\\resources\\itext\\fusion\\monfichier.pdf";
File fileBL = new File(baseDir, relatifRessouceFolder);
```

## Get Path Properties
```
getClass().getClassLoader().getResource("reservoir.properties")
```

### Properties files
```
InputStream propertiesFile = this.getClass().getClassLoader().getResourceAsStream("config.properties");
Properties props = new Properties();
props.load(propertiesFile);

//Etablisssement de la connexion.
String urlConnection = props.getProperty("connection");
String user = props.getProperty("user");
String mdp = props.getProperty("password");
connexion = DriverManager.getConnection(urlConnection, user, mdp);

logger.info("ouverture de la connexion");
```