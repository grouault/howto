## SPRING-AOP

[retour](./../index-spring.md)

### Principe

<pre>
La programmation par Aspect a pour but :
* séparation du code métier et du code technique
* les tâches transverses (et plutôt technique) sont à géré via des aspects
* le code métier n'est ainsi plus polluer par ces tâches
* évite donc la répétitition de code redondant
</pre>

### AspectJ / Spring AOP

<pre>
AspectJ : 
    - modifie le bytecode pour le tissage
    - langage AOP complet - technologie initiale

Spring AOP : 
    - utilise le mécanisme de proxy Java pour le tissage
    - implémentation Java de l'AOP intégrant AspectJ
</pre>

### Aspect / Target

#### Aspect

<pre>
Un aspect va modifier la logique de l'application.
L'aspect est la classe qui contient le code Java à insérer dans la logique de l'application.
Un aspect permet de définir un ou plusieurs traitements (Advice)

L'aspect intercepte l'appel de la méthode et exécute le greffon ou l'advice.
</pre>

#### Target

<pre>
Il s'agit de l'objet visé 
un objet Target peut être visés par plusieurs aspect
</pre>

### JointPoint

<pre>
* correspond au point d'exécution du programme autour duquel un ou des aspects sont greffés
* ils font références à des évènement du programmes (voir PointCut)
    * appel d'une méthode
    * appel de constructeur
    * atttribut get, set
    * levé des exceptions
</pre>

### PointCut

#### Principe

<pre>
* Un point de coupe représente / cible un ensemble de JointPoint.
* Un point de coupe est définit à l'aide d'une WildCard.
</pre>

#### Evenement : Execution / Call (AspectJ)

<pre>
Deux évènements peuvent être utilisé pour définir les points de coupe:
* execution
* call
Suivant cet évènement, le tissage n'a pas lieu au même moment et le JoinPoint
ne sera pas placé au même endroit dans le code.
<b>execution</b> : 
    * coupe à l'execution
    * le tissage à lieu dans la classe ciblée
    * le contexte est celui de la classe appelée
<b>call</b>:
    * coupe à l'appel de la méthode
    * le tissage est placé avant l'appel de la méthode
    * le contexte est celui de la méthode appelante

<b>Note</b> : spring AOP ne supporte pas l'evènement call
</pre>

#### WildCard

<pre>
Syntaxe qui permet de définir des PointCut.
Ce n'est pas une expression régulière mais cela correpond à une syntaxe bien précise.
C'est cette syntaxe qui permet de cibler les JoinPoint.
</pre>

### Advice (Greffon)

<pre>
* c'est l'un des traitements à réaliser par l'Aspect
* il peut y avoir plusieurs Advices par Aspect.
</pre>

### Weaving

#### Principe

<pre>
Cette étape corresond à la phase du tissage des aspects.
Le weaving est assuré par un framework qui exécuter alors tous PointCut. 
Le code est modifié pour introduction des greffons au niveau des JointPoint.

Suivant le framework, le mode opératoire,
n'est pas le même :
- <b>AspectJ</b> : le tissage est effectué à la compilation.
Les greffons sont insérés directement dans le bytecode.

- <b>Spring AOP</b>: le tissage est exécuté à l'execution
* Le bytecode n'est alors pas modifié.
* grâce au pattern Proxy (interception des appels de méthodes)
</pre>

## exercices

[exos](./exercices.md)
