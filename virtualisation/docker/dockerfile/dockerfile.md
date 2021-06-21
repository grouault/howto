## docker file

[retour](../docker.md)

### url
* https://putaindecode.io/articles/les-dockerfiles/

### D�finition
<pre>
* comment cr�er une image ou une nouvelle application
* fichier dans lequel est d�crit avec des commandes de base la mani�re avec laquelle on va construire l'image
* une image se compose de plusieurs couches (layer)
</pre>	
	
### Commandes
<pre>	
* add : copier des fichers source dans le host du conteneur
* entrypoint: quel est l'application qui va s'ex�ctuer ; point d'entr�e
* env: 
* expose : exposer le num�ro de port
* From : image de base
* RUN : pour ex�cuter
* VOLUME : pour activer les volumes
* WORKDIR : espace de travail
</pre>

![img](../img/docker-file/0-dockerfile-cmd.PNG)

## Cr�er une image	

### exemple avec simple appli-web

![img](../img/docker-file/1-create-image.PNG)
<pre>
* utiliser une image d'un conteneur web pour la couche sup�rieur
* g�n�rer l'image : <b>docker build</b>
	-t : donner un nom � l'image
	. : specifier le dossier ou se trouver le fichier Dockerfile
* ex�cuter l'image : <b>docker run</b>
</pre>

![img](../img/docker-file/1-create-image.PNG)
![img](../img/docker-file/2-execute-image.PNG)

### Exemple avec appli-Spring-Boot

#### Principe
<pre>
* appli java
* se base sur image java
	* se base sur l'openjdk
	* sp�ficier un volume
		* application a besoin d'un folder temporaire
* cr�ation du dockerfile
</pre>

#### Dockerfile
<pre>
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD target/demo*.jar /app.jar
CMD ["java", "-jar", "/app.jar", "--spring.profiles.actives=prod"]
EXPOSE 8080
</pre>
	
#### D�ploiement
<pre>
* <b>packaging</b> :
	* g�n�ration du jar avec maven
	* mvn package
* <b> g�n�rer l'image </b> :
	$ docker build -t demo-web-spb .
* <b>ex�cuter l'image </b>: 
	$ docker run -d -p 8087:8080 demo-web-spb
</b>
</pre>

![img](../img/docker-file/3-appli-spring-boot.PNG)
