## Virtualisation

### Structure d'un ordinateur - HardWare

#### Processeur

```
- CPU [ULA + Registre]
	* A partir du P4, augmentation de fréquence élevé, la matière du microprocesseur chauffe, quand ça chauffe performance diminue
	* Le mp est incapable d'augmenter ses performances avec cette fréquence
	* la loi de Moore ne tient plus
	* La solution pour accroitre les performances des ms ne viendrait pas d'une augementation de fréquence mais en faisant du multi-processeur
	* Apparition des processus mutli-coeur, capable d'effectuer plusieurs instruction en même temps
	
- GPU : Graphical processing unit => comment accélérer le rendu graphique pour les jeux	
	* ce qui rend puissant : architecture massivement parallèle
	* Carte-graphique : NVidia
		- offre des milliers de petits processeur graphiques
		- animation 3G: 30 images par s | chaque image 640 *1080, beaucoup de pixels
		- avec 1CPU, incapable de faire un rendu en temps réel
		- on fait le calcule avec le GPU (calcul massif parallèle)
		- important pour l'intelligence artificielle
		- a partir de 2010, ouverture du GPU pour le calcul scientifique (calcul matricielle)
```

	
#### RAM :

``` 
* données valatiles
* instruction des programmes chargés dans la RAM
* exécuté par le processeur
```

#### Disque Dur

```
* unités de persistence (Sata | SD)
```

#### BIOS | EEROM | CMOS 

```
* BIOS : premier programme qui démarre sur un PC, stocké dans mémoire morte ROM (une fois stocké, on ne peut plus modifié)
* EEPROM : maintenant ce sont des EEPROM (ROM pragrammable, mais qu'on peut modifier par programme (voie éléctrique |flashé))
	- permet d'effacer et rempacer le programme
* CMOS : stocke l'ensemble de données de configuration de la machine dont l'option de virtualisation

* BIOS:
* qd l'ordinateur est mis sous tension, le système charge le bios dans la RAM et le CPU l'exécute
* bios (basic input output system) : mini OS de base qui permet d'aller faire les éléments matériels d'E/S
* bios est chargé en mémoire
* opération de base d'E/S sont faites par le BIOS 

AUTO-TEST
* le bios fait alors l'autotest de démarrage :
	- test de fonctionnalité du matériel : si tous les éléments sont connectés
* l'autotest de démarrage est configurable via le Setup qui permet d'accèder aux données de configuration de la machine 
	Exemple de configuration :
	* le nombre de disque dur
	* sur quel élément booter
	* activer l'option de virtualisation

BOOT
* une fois l'autotest, setup effectué, passage au boot 	
* boot : va vers un secteur particulier (boot) du disque dur pour démarrer l'OS
* l'os, le bios, va le chercher dans la configuration du Setup
* qd un OS est trouvé dans le boot, le système d'exploitation est démarré
* l'OS va alors géré toutes les applications en permettant leur accès aux différentes ressources du PCs
* tout est orchestré par l'OS mais qui s'appuie sur le BIOS qui fait les opérations de base
	
* dual boot : choisir l'OS sur lequel on boot
	* impossible d'utiliser deux OS en même temps
```

#### Adapters 
* cartes permettant de connecter le PC avec le monde extérieur
		
		
### Principe de la virtualisation
```
* comment démmarrer plusieurs OS en même temps dans une même machine	
* VMWare: créer une application qui va créer des machines virtuelles
* Application de virtualisation (VMware) : Hyperviseur
* Faire fonctionner sur une même machine physique plusieurs environnements comme s'ils fonctionnent dans plusieurs machines physiques distinctes.
```

#### Créer une machine virtuelle

##### Principe
```
* créer un environnement dans lequel seront créés des composants virtuels (comparaison avec le modèle objets) et non des composants physiques.
* parmi les composants virtuels : disque dur virtuel, BIOS, tous les adaptateurs (carte réseau) 
	Attention : sauf le processeur, CPU qui sont des ressources partagées, RAM également je pense.
* composant virtuel = objet virtuel 
* L'ensemble des composants virtuels permettent de créer une application/machine qui représente l'architecture physique de l'ordinateur, 
	application qui va traduire l'architecture physique de l'ordinateur hôte mais sous forme de composants virtuels
* Les composants virtuels vont se charger de traduire les appels d'OS ves l'OS hôte qui permet d'accéder aux ressources matérielles
* Qd on démarre cette machine, on peut démarrer un nouveau OS qui ne connaît que les composants virtuels
* On a donc les couches suivantes pour représenter une machine virtuelle
	- couche des applications (app1, app2, ...)
	- couche OS (OS invité)
	- composants virtuels
	- hyperviseur (application / couche de virtualisation)
	- OS hôte - ordinateur hôte
	- composants hardware hôte
* qd une application veut écrire vers le disque dur, l'application écrit sur le disque dur virtuel ; 
	le composant virtuel traduit l'opération vers une écriture physique
* composant virtuel : c'est un proxy qui va interprété et demandé à l'hyperviseur de faire l'écriture sur disque en passant par l'OS hôte
```

##### Performances et partage des ressources

```
* on peut démarrer une ou plusieurs machines virtuelles
* les machines virtuelles partagent les mêmes ressources
* chaque machine vituelle se voit allouer des ressources processeurs: CPU, RAM
* si tout ce que l'on fait se trouve dans les machine virtuelles, pourquoi pas utiliser l'hyperviseur comme OS
	* On a besoin de l'essentiel pour gérer les E/S
	* l'hyperviseur peut jouer ce rôle et remplacer l'OS hôte
```

### Hyperviseur

```
C'est une couche de virtualisation qui permet :
* assurer le contrôle des processeurs et des ressources de la machnine physique hôte
* alloue à chaque machine virtuelle les ressources dont elle a beoin
* s'assure que les VM ne s'interfèrent pas
* 2 types d'hyperviseur
	- hyperviseur de type 1
		* l'hyperviseur joue le rôle de l'OS hôte
		* s'exécute directement sur le hardware
		* XEN, Oracle VM, VMware ESX
	- hyperviseurde type 2
		* hyperviseur se repose sur l'OS hôte
		* VMware WS, VMware Fusion(mac), Virtual BOX (gratuit)
```

### Virtualisation Complète

```
* permet de faire fonctionner n'importe quel OS en tant qu'invité dans la machine virtuelle
* OS invité n'a pas conscience d'être virtualisé
* OS utilise directement les composants virtuels de la VM
* c'est la VM qui traduit les appels aux composants virtuels vers les composants physiques
* plus simple à réaliser
```

### Paravirtualisation

```
* les systèmes d'exploitation doivent être modifiés pour fonctionner sur un hyperviseur de paravirutalisation 
	* consiste à installer des drivers spécifiques
* les modifications sont en fait des insertions de drivers permmettant de rediriger les appels systèmes au lieu de les traduire
* En virtualisation complète, les composants virtuels interprète les appels pour les traduire vers des appels systèmes physiques
* En paravirtualisation, les appels systèmes sont redirigés directement vers les composants physiques (via les drivers installés sur l'OC)
* l'OS est conscient qu'il tourne dans une environnement virtuel
* plus performante que la virtualisation complète
* des drivers backends et frontends sont installés dans les OS para virtualisés
* il est donc intelligent d'utiliser un tel mécanisme pour accéder à du materiel potentiellement très sollicité (dd, interface réseau,...)
* Ex: KVM, XEN, VMware ESX, Hyper-V (microsoft)

```
