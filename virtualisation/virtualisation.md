## Virtualisation

### Structure d'un ordinateur - HardWare

#### Processeur

<pre>
- CPU [ULA + Registre]
	* à partir du P4, augmentation de fréquence élevé, la matière du microprocesseur chauffe
	* quand ça chauffe performance diminue
	* le mp est incapable d'augmenter ses performances avec cette fréquence
	* la loi de Moore ne tient plus
	* la solution pour accroitre les performances des ms ne viendrait pas d'une augementation de fréquence 
		mais en faisant du multi-processeur
	* apparition des processus mutli-coeur, capable d'effectuer plusieurs instruction en même temps
	
- GPU : Graphical processing unit => comment accélérer le rendu graphique pour les jeux	
	* ce qui rend puissant : architecture massivement parallèle
	* carte-graphique : NVidia
		- offre des milliers de petits processeur graphiques
		- animation 3G: 30 images par s | chaque image 640 *1080, beaucoup de pixels
		- avec 1CPU, incapable de faire un rendu en temps réel
		- on fait le calcule avec le GPU (calcul massif parallèle)
		- important pour l'intelligence artificielle
		- a partir de 2010, ouverture du GPU pour le calcul scientifique (calcul matricielle)
</pre>

#### RAM :
<pre>
* données valatiles
* instruction des programmes chargés dans la RAM
* exécuté par le processeur
</pre>

#### Disque Dur
<pre>
* unités de persistence (Sata | SD)
</pre>

#### BIOS | EEROM | CMOS 
<pre>
* <b>BIOS</b> : premier programme qui démarre sur un PC, stocké dans <b>mémoire morte ROM</b> (une fois stocké, on ne peut plus modifié)
* <b>EEPROM</b>: maintenant ce sont des EEPROM (<b>ROM pragrammable</b>, mais qu'on peut modifier par programme (voie éléctrique |flashé))
	- permet d'effacer et rempacer le programme
* <b>CMOS</b> : stocke l'ensemble de données de configuration de la machine dont l'<i>option de virtualisation</i>
</pre>

##### BIOS et démarrage du PC:
<pre>
* qd l'ordinateur est mis sous tension, le système charge le <b>bios dans la RAM</b> et le CPU l'exécute
* bios (basic input output system) : <b>mini OS de base</b> qui permet de gérer les éléments matériels d'E/S
* <b>opérations</b> de base d'<b>E/S</b> sont faites par le BIOS 
</pre>

##### Auto-test et Setup
<pre>
* le <b>bios</b> fait alors l'<b>autotest de démarrage</b> :
	* c'est un test de <b>fonctionnalité du matériel</b> :
	* le bios teste si tous les éléments sont connectés
* l'autotest de démarrage est <b>configurable via le Setup</b> qui permet d'accèder aux <b>données de configuration</b> de la machine 
	Exemple de configuration :
	* le nombre de disque dur
	* sur quel élément booter
	* activer l'option de virtualisation
</pre>

##### Boot
<pre>
* une fois l'autotest, setup effectué, passage au boot 	
* <b>boot</b> va vers un <b>secteur</b> particulier (boot) du <b>disque dur</b> pour démarrer l'<b>OS</b>
* le bios va chercher les infos de l'OS dans la <b>configuration du Setup</b>
* qd un OS est trouvé dans l'opération de boot, l'<b>OS est démarré</b>
* l'<b>OS</b> va alors gérer toutes les applications 
	 en permettant leur accès aux différentes ressources du PCs
* tout est orchestré par l'<b>OS</b> mais il <b>s'appuie sur le BIOS</b> 
	pour faire les <b>opérations de base</b> d'E/S
	
* dual boot : choisir l'OS sur lequel on boot
	* impossible d'utiliser deux OS en même temps
</pre>

#### Adapters 
<pre>
* cartes permettant de connecter le PC avec le monde extérieur
	* réseau (ethernet)
	* moniteur (vga)
	* usb (souris, clavier)
	* bluetooth
	...
</pre>		
		
### Principe de la virtualisation
<pre>
<i>Principe</i>
* démarrer et faire fonctionner sur une même machine physique plusieurs environnements / OS
	comme s'ils fonctionnent dans plusieurs machines physiques distinctes.
</pre>	
![architecture](1-definition-virtualisation.PNG)
	
#### application de virtualisation
<pre>	
<b>Hyperviseur</b> : 
* application de virtualisation (VMware ou VirtualBox) 
	qui va créer et gérer des <b>machines virtuelles</b>
</pre>
![architecture](0-architecture-virtualiation.PNG)

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
