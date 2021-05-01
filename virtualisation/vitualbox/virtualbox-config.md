## VM Ubuntu
```
* login: grouault
* password:gildas1234
* ssh grouault@grouault-VirtualBox
```

## VM Ubuntu Server
```
* ssh grouault@ub-server
* login: grouault
* password: 1234
```

## VM Fedora Server
```
* root: grouault
* password: gildas1234
```

## installation
```
* installation local des VMs:
C:\Users\grouault\VirtualBox VMs


* installation des images
C:\Users\grouault\VirtualBox VMs\UbuntuServer\UbuntuServer.vdi
```

### hosts
```
Windows
C:\Windows\System32\drivers\etccvap
```

* Question : install-docker?
Ou est installé docker-host / docker-engine sur la VM?

## Création d'adaptateur
* pour créer une nouvelle carte réseau virtuelle.

## Configuration Réseau 

### connexion à Internet en NAT
Aucune configuration n'est à faire pour faire cela
> test connexion internet
$ ping google.com
En NAT, c'est VB qui attribue une adresse IP dynamique à la machine virtuelle
Addresse IP qui est fournit par défaut à la machine : 10.0.2.15
$ ip a
inet 10.0.2.15/24 brc
Avec cet IP, la machine peut se connecter à internet car VB va faire la translation d'adresse (pour tous les paquets envoyés) de façon à utiliser la carte ethernet physique de la machine.

### Tester les applications en dehors de la machine virtuelle
* En NAT, il y a un pb. Ce n'est pas configuré par défaut.

### configuration Acces-Pont
* machine virtuelle va utiliser la même interface réseau que la machine physique
* exactement comme s'il s'agit d'une vraie machine physique
* on peut pinger d'une machine à l'autre
* par contre pas d'internet

### configuration Réseau Privé
Configuration avec plusieurs interface
* interface 1 : NAT pour avoir accès Internet
* interface 2 : Réseau privé hôté pour permettre à la VM de contacter l'extérieur
	* création d'un réseau privé sur la machine virtuelle mais connecté à la machine hôte
	* pour un réseau privé, il faut préciser l'adaptateur à utiliser : carte réseau
		* carte pour pouvoir accèder au réseau
	* pour cela, il est possible de créer un adaptateur
	
## SSH : connection serveur à distance
```
* sur la version Desktop, il faut installer OpenSsh
* sudo apt-get install openssh-server
* sur la version Server, OpenSsh est déjà installé
```


	


```	