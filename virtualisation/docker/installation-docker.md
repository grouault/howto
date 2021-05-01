## installation

[retour](notes-docker.md)

### Structure
```
* La structure normale :
	* une machnie h�te (machine physique)
	* une machine virtuelle sur la machine h�te
	* un conteneur sur la machine virtuelle
	* une application g�r� par le conteneur
```

### Installation de docker

* il faut s'assurer de la version de Linux
```
> Permet de voir la version de l'OS install�
$ cat /etc/*relesase*
```

* Url pour checker les version de linux pour installer Docker.
```
https://docs.docker.com/engine/install/
```

* Uninstal old versions
![uninstall](installation/0-installation.PNG)



* Installation � partir d'un script qui fait l'installation et mise � jour de Docker.

```
> T�l�charger le script
$ curl -fsSL https://get.docker.com -o get-docker.sh
> installer curl si besoin
$ sudo apt-get install curl
> Ex�cuter le script
$ sudo sh get-docker.sh
```

![install](installation/2-installation.PNG)

	
* checker l'installation
```
$ docker version
```

![version](installation/3-installation-check-version.PNG)


### T�l�charger des images pour tester

#### whalesay

```
* t�l�charger image sur DockerHub : whalesay
* application simple qui permet d'afficher un message
```

```
$ docker run docker/whalesay cowsay exagone
```	