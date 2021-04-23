## Virtualisation

### Structure d'un ordinateur - HardWare

#### Processeur

```
- CPU [ULA + Registre]
	* A partir du P4, augmentation de fr�quence �lev�, la mati�re du microprocesseur chauffe, quand �a chauffe performance diminue
	* Le mp est incapable d'augmenter ses performances avec cette fr�quence
	* la loi de Moore ne tient plus
	* La solution pour accroitre les performances des ms ne viendrait pas d'une augementation de fr�quence mais en faisant du multi-processeur
	* Apparition des processus mutli-coeur, capable d'effectuer plusieurs instruction en m�me temps
	
- GPU : Graphical processing unit => comment acc�l�rer le rendu graphique pour les jeux	
	* ce qui rend puissant : architecture massivement parall�le
	* Carte-graphique : NVidia
		- offre des milliers de petits processeur graphiques
		- animation 3G: 30 images par s | chaque image 640 *1080, beaucoup de pixels
		- avec 1CPU, incapable de faire un rendu en temps r�el
		- on fait le calcule avec le GPU (calcul massif parall�le)
		- important pour l'intelligence artificielle
		- a partir de 2010, ouverture du GPU pour le calcul scientifique (calcul matricielle)
```

	
#### RAM :

``` 
* donn�es valatiles
* instruction des programmes charg�s dans la RAM
* ex�cut� par le processeur
```

#### Disque Dur

```
* unit�s de persistence (Sata | SD)
```

#### BIOS | EEROM | CMOS 

```
* BIOS : premier programme qui d�marre sur un PC, stock� dans m�moire morte ROM (une fois stock�, on ne peut plus modifi�)
* EEPROM : maintenant ce sont des EEPROM (ROM pragrammable, mais qu'on peut modifier par programme (voie �l�ctrique |flash�))
	- permet d'effacer et rempacer le programme
* CMOS : stocke l'ensemble de donn�es de configuration de la machine dont l'option de virtualisation

* BIOS:
* qd l'ordinateur est mis sous tension, le syst�me charge le bios dans la RAM et le CPU l'ex�cute
* bios (basic input output system) : mini OS de base qui permet d'aller faire les �l�ments mat�riels d'E/S
* bios est charg� en m�moire
* op�ration de base d'E/S sont faites par le BIOS 

AUTO-TEST
* le bios fait alors l'autotest de d�marrage :
	- test de fonctionnalit� du mat�riel : si tous les �l�ments sont connect�s
* l'autotest de d�marrage est configurable via le Setup qui permet d'acc�der aux donn�es de configuration de la machine 
	Exemple de configuration :
	* le nombre de disque dur
	* sur quel �l�ment booter
	* activer l'option de virtualisation

BOOT
* une fois l'autotest, setup effectu�, passage au boot 	
* boot : va vers un secteur particulier (boot) du disque dur pour d�marrer l'OS
* l'os, le bios, va le chercher dans la configuration du Setup
* qd un OS est trouv� dans le boot, le syst�me d'exploitation est d�marr�
* l'OS va alors g�r� toutes les applications en permettant leur acc�s aux diff�rentes ressources du PCs
* tout est orchestr� par l'OS mais qui s'appuie sur le BIOS qui fait les op�rations de base
	
* dual boot : choisir l'OS sur lequel on boot
	* impossible d'utiliser deux OS en m�me temps
```

#### Adapters 
* cartes permettant de connecter le PC avec le monde ext�rieur
		
		
### Principe de la virtualisation
```
* comment d�mmarrer plusieurs OS en m�me temps dans une m�me machine	
* VMWare: cr�er une application qui va cr�er des machines virtuelles
* Application de virtualisation (VMware) : Hyperviseur
* Faire fonctionner sur une m�me machine physique plusieurs environnements comme s'ils fonctionnent dans plusieurs machines physiques distinctes.
```

#### Cr�er une machine virtuelle

##### Principe
```
* cr�er un environnement dans lequel seront cr��s des composants virtuels (comparaison avec le mod�le objets) et non des composants physiques.
* parmi les composants virtuels : disque dur virtuel, BIOS, tous les adaptateurs (carte r�seau) 
	Attention : sauf le processeur, CPU qui sont des ressources partag�es, RAM �galement je pense.
* composant virtuel = objet virtuel 
* L'ensemble des composants virtuels permettent de cr�er une application/machine qui repr�sente l'architecture physique de l'ordinateur, 
	application qui va traduire l'architecture physique de l'ordinateur h�te mais sous forme de composants virtuels
* Les composants virtuels vont se charger de traduire les appels d'OS ves l'OS h�te qui permet d'acc�der aux ressources mat�rielles
* Qd on d�marre cette machine, on peut d�marrer un nouveau OS qui ne conna�t que les composants virtuels
* On a donc les couches suivantes pour repr�senter une machine virtuelle
	- couche des applications (app1, app2, ...)
	- couche OS (OS invit�)
	- composants virtuels
	- hyperviseur (application / couche de virtualisation)
	- OS h�te - ordinateur h�te
	- composants hardware h�te
* qd une application veut �crire vers le disque dur, l'application �crit sur le disque dur virtuel ; 
	le composant virtuel traduit l'op�ration vers une �criture physique
* composant virtuel : c'est un proxy qui va interpr�t� et demand� � l'hyperviseur de faire l'�criture sur disque en passant par l'OS h�te
```

##### Performances et partage des ressources

```
* on peut d�marrer une ou plusieurs machines virtuelles
* les machines virtuelles partagent les m�mes ressources
* chaque machine vituelle se voit allouer des ressources processeurs: CPU, RAM
* si tout ce que l'on fait se trouve dans les machine virtuelles, pourquoi pas utiliser l'hyperviseur comme OS
	* On a besoin de l'essentiel pour g�rer les E/S
	* l'hyperviseur peut jouer ce r�le et remplacer l'OS h�te
```

### Hyperviseur

```
C'est une couche de virtualisation qui permet :
* assurer le contr�le des processeurs et des ressources de la machnine physique h�te
* alloue � chaque machine virtuelle les ressources dont elle a beoin
* s'assure que les VM ne s'interf�rent pas
* 2 types d'hyperviseur
	- hyperviseur de type 1
		* l'hyperviseur joue le r�le de l'OS h�te
		* s'ex�cute directement sur le hardware
		* XEN, Oracle VM, VMware ESX
	- hyperviseurde type 2
		* hyperviseur se repose sur l'OS h�te
		* VMware WS, VMware Fusion(mac), Virtual BOX (gratuit)
```

### Virtualisation Compl�te

```
* permet de faire fonctionner n'importe quel OS en tant qu'invit� dans la machine virtuelle
* OS invit� n'a pas conscience d'�tre virtualis�
* OS utilise directement les composants virtuels de la VM
* c'est la VM qui traduit les appels aux composants virtuels vers les composants physiques
* plus simple � r�aliser
```

### Paravirtualisation

```
* les syst�mes d'exploitation doivent �tre modifi�s pour fonctionner sur un hyperviseur de paravirutalisation 
	* consiste � installer des drivers sp�cifiques
* les modifications sont en fait des insertions de drivers permmettant de rediriger les appels syst�mes au lieu de les traduire
* En virtualisation compl�te, les composants virtuels interpr�te les appels pour les traduire vers des appels syst�mes physiques
* En paravirtualisation, les appels syst�mes sont redirig�s directement vers les composants physiques (via les drivers install�s sur l'OC)
* l'OS est conscient qu'il tourne dans une environnement virtuel
* plus performante que la virtualisation compl�te
* des drivers backends et frontends sont install�s dans les OS para virtualis�s
* il est donc intelligent d'utiliser un tel m�canisme pour acc�der � du materiel potentiellement tr�s sollicit� (dd, interface r�seau,...)
* Ex: KVM, XEN, VMware ESX, Hyper-V (microsoft)

```
