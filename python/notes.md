[home](index.md)

## utils

### constante

- pas de constante à proprement parler mais une convention,
il faut mettre la variable en majuscule
<pre>
NOMBRE_MAGIQUE = random.randint(NOMBRE_MIN, NOMBRE_MAX)
</pre>

### None

- permet de représenter un objet vide
- initialiser un objet vide
- En retour de fonction on peut tester de la manière suivante :
  <pre>
  # Pour un objet non défini
  if not Objet: // True si Object non défini
    // là on a obtenu un None / un objet vide
  else:
    // Objet a bien une valeur
  </pre>

### if not | None

- if not: négation

  <pre>
  if not age == 0 <==> if age != 0
  
  if not personne : 
    => //True si personne vaut None
  </pre>

### Ternaire

1- mode if

  <pre>
  str_genre = "Masculin" if self.genre else "Feminin"
  </pre>

2- mode ternaire

  <pre>
  # type string
  str_genre = self.genre and "Masculin" or "Féminin"
  print("Genre " + (self.genre and "Masculin" or "Féminin"))
  
  # type int
  maximum = nb_pizza_to_show > 0 and nb_pizza_to_show or len(pizzas)
  </pre>

### incrementer / decrementer

<pre>
i += 10
i -= 10
</pre>

### Commentaire

<pre>
# : commenter une ligne
''' ''': commenter plusieurs lignes
</pre>

### affectation-multiple

<pre>
nom, prenom = "rouault", "gildas"
print(nom, prenom)
</pre>

## Librairie Mahtematiques

<pre>
import random
NOMBRE_MAGIQUE = random.randint(NOMBRE_MIN, NOMBRE_MAX)

moyenne = int(NB_QUESTIONS / 2)
</pre>

### pass

- mot clé permettant de remplacer l'implémentation d'une méthode
<pre>
class Personne:
  pass

def ma_methode():
pass

</pre>

## Chaine de caractères

### Chaine de caractères et tuple

- une chaine de caractère se comporte comme un tuple
- récupération de la longueur et le la première lettre des personnes
<pre>
  for i in personnes:
    print(i, len(i), i[0], i[-1])
</pre>

### savoir si un caractère contient une valeur

- if "e" in chaine_caractere:
  <pre>
    if "z" in nom.lower()
  </pre>
- find: chaine_caractère.find(search_chaine)
  - retourne l'index de début
  - retoure -1 si non trouvé

### isdigit()

- permet de tester si le caractère est un nombre
<pre>
"1".isdigit()
</pre>

### rindex()

- retourne le dernier index ou une chaine est trouvée:
<pre>
  str1 = "this is string example....wow!!!";
  str2 = "is";
  print str1.rindex(str2) ==> 5
  print str1.index(str2) ==> 2
</pre>

## boucle for

### principe

- permet de boucler un nombre de fois
  - range : dans l'ensemble [inclusif, exclusif]
  <pre>
  # on boucle 4 fois en partant de 0
  for i in range(0,4):
  print i
  </pre>
- permet de boucler sur un nombre d'éléménts
  <pre>
  notes = [4,5,6,7,8]
  # toutes les notes
  for i in notes:
    print(i)
  </pre>

### sur une chaine

- rappel : une chaine de caractère peut être vue comme un ensemble
<pre>
  ma_chaine = "un chien se promène dans la nature"
  for c in ma_chaine:
      print(c)
</pre>

### sur un ensemble (tupe | liste)

<pre>
  ma_chaine = "un chien se promène dans la nature"
  l_ma_chaine = ma_chaine.split()
  print(l_ma_chaine)
  for e in l_ma_chaine:
      print(e)
  ==> Result 
  ['un', 'chien', 'se', 'promène', 'dans', 'la', 'nature']
  un
  chien
  ...
</pre>

### sur un dictionnaire

<pre>
  notes = {"math": 15, "francais": 12, "anglais": 14}
  # parcours des clés
  for k in notes:
      print(k, notes[k])

  # parcours des valeurs
  for v in notes.values():
      print(v)

  # parcours des clés et valeurs
  for k, value in notes.items():
      print(k, value)
</pre>

## Fonctions

### arguments vs paramètres

- paramètre d'une fonction : utilisé pour définir les paramètres
- arguments d'une fonction : utilisé pour passer des valeurs à l'appel de la fonction

### paramètres nommés

- il est possible de nommer les paramètres à l'appel d'une fonction
- il suffit de préciser le nom de l'argument
- dans ce cas, il est possible de ne pas respecter l'ordre des arguments
<pre>
  def maFonction(param1, param2):
    ...
  maFonction(param1=2, param2=3)
</pre>

### recuperer plusieurs paramètres de la fonction

- fonction qui renvoit plusieurs paramètres
- en fait, cela renvoit un tuple, qui peut alors être desctructurer
<pre>
def ma_fonction():
    return 2,3
a,b = ma_fonction()
</pre>

### passer plusieurs paramètres

- type énuméré : \*args ==> tuple
- transforme la liste des paramètres en tuple
  <pre>
  def somme(*nombres):
      somme = 0
      for i in nombres:
          somme += i;
      return somme
  
  print(somme(5,2,5,2))
  </pre>

- \*\*args ==> dictionnaire(clé, valeur)
- permet de passer un dictonnaire en paramètre
  <pre>
    def somme(titre, **nombres):
        print(titre)
        somme = 0
        for i in nombres.values():
            somme += i
        return somme
    
    print(somme("somme = ", maths=5,geo=2,anglais=5,sport=2))
  </pre>

### break vs return vs exit

- le break s'utilise dans une boucle
  - Pour arrêter l'exécution de la boucle avant la fin
  - n'arrête pas l'exéution d'une fonction comme le fait return
  - break : pas de notion de renvoi de résultat
  <pre>
    #on boucle 4 fois en partant de 0
    for i in range(0,4):
      print i
      if i == 2:
      break
  </pre>
- return
  - sortir d'une fonction
  - renvoyer une valeur

* exit
  - sert au niveau du programme principal pour arrêter son exécution
  - permet de spécifier un code erreur : exit(0) | exit(1) | exit(2)
  - ce code peut-être exploiter par le programme principal ou le terminal

### récursion

- fonction qui s'appelle elle-même
- Avec retour de valeur :
  - fonction bloquante: on attent la fin de la fonction appelée pour que la fonction appelante
    termine son exécution.
  - il faut récupérer le retour de l'appel précédent et le retourner
- Sans retour de valeur :
  - Une fonction récursive s'appelle elle-même avec une condition de sortie
  - sans condition de sortie: en boucle infinie
  <pre>
    def a(n, limit=100000):
        if n > limit:
            return
        print("n = ", n)
        a(n * n)
    
    a(2, 100000)
  </pre>

### callback :

- le fait de stocker une fonction dans une variable ou passer la ref ou la fonction à une autre fonction
<pre>
  def ma_fonction(fonction_cbk):
    fonction_cbk()

  def ma_fonction_cbk():
      print("toto")
      return 1

  ma_fonction(ma_fonction_cbk)
</pre>

### lambda :

- fonction qui n'ont pas de nom. On a pas créer la fonction.
  <pre>
  syntaxe: lambda parametre1, parametre2 ... : corps de la fonction
  lambda a,b : a + b
  </pre>
- permet de créer un callback
  <pre>
    def afficher_table(n, operateur, operation_cbk, min=0, max=10):
        for i in range(min, max):
            print(f"{n}{operateur}{i}=", operation_cbk(n, i))
  
    afficher_table(4, "*", lambda a,b : a * b)
  
  </pre>

* utiliser beaucoup pour les fonctions asynchrone
* permet d'enregistrer une fonction et d'exécuter du code quand la fonction asyncrhone est terminée

## Collections

- une collection est un ensemble d'éléments
  - tuple, liste, dictionnaire, chaine de caractère

### TUPLE

- immutable -> non modifiable
- -1 pour récupérer le dernier élément
  <pre>
    personnes = ("Mélanie","Jean","Martin","Alice")
    print(type(personnes))
    print(personnes[0])
    print(len(personnes))
    # parcours avec l'index
    for i in range(0, len(personnes)):
    print(personnes[i])
    # récupération de la valeur directement
    for i in personnes:
    print(i)
  </pre>

#### range et tuple

- range se comporte comme un tuple
- range est un ensemble d'éléments sur lequel on itère
  <pre>
    # tuple et range
    valeur = range(0,5) => créé le type (0,1,2,3,4)
    print(type(valeur))
    print(valeur[0])
  </pre>

#### Fonction et tuple

##### destructuring sur un retour de fonction

- une fonction peut retourner un tuple que l'on peut desctructurer
<pre>
  def obtenir_information():
      return "Mélanie", 32, 1.6

  infos = obtenir_information()
  nom, age, taille = obtenir_information()
  print('infos = ', infos[0], infos[1], infos[2])
  print('nom=', nom, '- age=', age, '- taille=', taille)
</pre>

##### destructuring sur les paramètres d'une fonction

- une fonction passe comme argument un tuple
- on veut destructurer le tuple au niveau des paramètres de la fonction
- Unpack du tuple: il faut ouvrir le tuple en le précédent par '\*' pour
séparer les paramètres avec une virgule
<pre>
  def obtenir_information():
      return "Mélanie", 32, 1.6

  def afficher_information(nom, age, taille):
    print(f"Informations: nom : {nom}, age: {age}, taille: {taille}")

  infos = obtenir_information()
  afficher_information(<b>*infos</b>)
</pre>

### LISTE :

#### mutable

- une liste, c'est comme un tuple avec la particularité suivante :
  - une liste est modifiable
  - on peut ajouter/supprimer des éléments ou les modifier

#### liste vs tuple

- un tuple est plus performant au niveau de la gestion mémoire
- utiliser un tuple et le convertir en liste si besoin

#### liste et fonction

- Quand on passe une liste à une fonction, si la liste est modifiée,
  la modification est prise en compte dans le programme principale.
- A la différence d'un paramètre classique, la liste est un conteneur et on
  modifie le conteneur et non la variable
- c'est une modification par référence et non par valeur

#### méthode de liste

##### append

- append : ajouter un élément et un seul élément à la liste
<pre>
  a1 = [1, 2, 3]
  a2 = [1, 2, 3]
  b = [4, 5, 6]
  a2.append(b) ==>  [1, 2, 3, [4,5,6]]
</pre>

##### extend

- extend | + | += : ajouter les éléments d'une autre collection à la collection courante
  <pre>
    a1 = [1, 2, 3]
    a2 = [1, 2, 3]
    b = [4, 5, 6]
    a1.extend(b) ==> [1,2,3,4,5,6]
  </pre>

- extend : chaine de caractère:
<pre>
  rows = ['a','t']
  chaine = "gildas"
  rows.extend(chaine)
  ==> result
  rows =  ['a', 't', 'g', 'i', 'l', 'd', 'a', 's']
</pre>

##### insert

- insert : insertion d'un élément à un index précis de la liste
  <pre>
    noms = ["Jean", "Sophie", "Martin"]
    noms_supplementaires = ["Christophe","Zoe"]
    # EXTEND
    noms+=noms_supplementaires
    # INSERT
    noms.insert(0,"Toto")
    noms.insert(1,"Titi")
    noms_add = ['Tata','Tonton']
    noms = noms_add + noms
    print("noms = ", noms)
    # Resultat: 
    noms =  ['Tata', 'Tonton', 'Toto', 'Titi', 'Jean', 'Sophie', 'Martin', 'Christophe', 'Zoe']
  </pre>

##### del

- del : supprimer un élément

  - on ne peut supprimer un élément de la liste qd on itère sur cette liste
  <pre>
   del personnes[0]
  </pre>

##### swap

- intervertir, swapper des valeurs d'une liste
  <pre>
  # intervertir deux valeurs d'une liste avec l'affectation-multiple
  noms[0], noms[2]=noms[2],noms[0]
  </pre>

##### join

- join: joindre les éléments de la collection pour en faire une chaine de caractères
  <pre>
  noms = ["Jean", "Sophie", "Martin"]
  print(",".join(noms))
  </pre>

##### split

- split: créer une liste à partir d'une chaine de caractères
  <pre>
  a = "Jean, Martin, Francois"
  a_split = a.split(",")
  </pre>

##### in

- in:
  - permet de savoir si un élément est dans la liste:
    <pre>
        # pizza => liste
        # pas besoin de boucle for
        if pizza_to_add in pizzas:
            return True
    </pre>

##### index

- index:
  - retourne l'index de la première valeur trouvée dans la liste
  - retourne une exeption si non trouvée
  <pre>
    if "Jean" in a_split:
      print(a_split.index("Jean"))
    else:
      print("absent")
  </pre>

##### count

- count: compter le nombre d'occurences dans la liste
  <pre>
    noms = ["Jean", "Sophie", "Martin", "John", "Joe", "Jack", "Martin"]
    element_cherche = "Martin"
    nb_occurences = noms.count(element_cherche)
    tab_index = []
    if element_cherche in noms:
        index_occurence = 0
        while len(tab_index) < nb_occurences:
            index_occurence = noms.index(element_cherche, index_occurence)
            if index_occurence >= 0:
                tab_index.append(index_occurence)
                index_occurence += 1
    else:
        print("absent")
    print("tab_index ", tab_index)
  </pre>

##### find

- find: attention 'find' fonctionne pour les chaine de caractères mais pas pour les listes.
  - pour les listes, il faut utiliser 'index'

##### min / max

- permet de trouver le min et le max dans une liste
- fonctionne pour les valeurs numériques
- attention pour les chaines de caractères, min et max sont évalués par rapport à la valeur des caracètres ascii
- si on veut la chaine la plus longue et la plus courte
<pre>
  print("min = ", min(chaine_trie, key=len))
  print("max = ", max(chaine_trie, key=len))
</pre>

#### Tris : Sort et sorted

##### sort : tri alphabétique (ASCII) - tri inplace qui altère la liste en mémoire

- il n'y a pas une nouvelle liste de créer
- on a plus la liste originale
  Chaque caractère est stocké en format binaire.
  <pre>
  # Tri inverse
  pizzas.sort(reverse=True)

##### sorted

- fonction qui prend en paramètres une collection et renvoit une nouvelle liste
  <pre>
    noms = ["Jean", "Sophie", "Martin"]
    nom_tries = sorted(noms, reverse=True)
    noms.sort(reverse=True)
    print(noms)
    print(nom_tries)
  </pre>

##### Tri personnalisé

- utilisé le mot key et une fonction (callback) associée qui va opérer sur chaque élément de la liste

  - 1- la fonction est appelée sur chaque élément
  - 2- sur la liste résultante, le tri s'applique
    <pre>
        # Tri personnalisé
        def tri_personnalise(e):
          return len(e)
          
        pizzas.sort(reverse=True, key=tri_personnalise)
    
        # autre ecriture
        pizzas.sort(key=lambda nom : len(nom))
        </pre>
    </pre>

### SLICE

- un slice s'applique sur une collection mais également sur les chaines de caractères
- [start:stop:step] : un slice permet de paracourir une collection avec le pattern suivant
- start : index de début
- stop : index de fin
- step : indique le pas d'itération
- un step négatif permet de commener l'itération à la fin de la collection
  <pre>
  # exemple: 
  noms[3:] : commencer à l'index 3
  noms[:3] : aller jusqu'à l'index 3
  </pre>

#### SLICE et copie de listes

- un slice créé une nouvelle liste
- un slice qui prend toutes les valeurs revient donc à faire une copie de la liste
  <pre>
    # Copie de liste (duplication de la liste en mémoire)
    slices_noms = noms[:]
  </pre>

#### SLICE et index négatif

- index négatif placé à la fin :
  - revient à supprimer des élément en partant de la fin de la liste
  <pre>
  noms[:-3] : supprime les 3 derniers éléments
  collection[:-n]: supprimer les n derniers éléments
  </pre>
- index négatif placé au début :
  - revient à garder les élements en partant de la fin de la liste
  <pre>
  # on ne garde que le dernier élément
  slices_noms[-1:]
  collection[-n:]: conserver les n derniers éléments
  </pre>

### Dictionnary : collection clé/valeur

- le dictionnaire est mutable
- on peut ajouter des clés dynamiquement
  <pre>
    personne = {"nom": 'Mélanie', "age": 25, "taille": 1.6 }
  
    print(personne["nom"])
    personne["poste"] = "Développeur"
    achats = ("Chocoalat", "beurre")
    personne["achats"] = achats
    print(personne, type(personne))
  
    # recuperer une valeur
  
    personne.get("nom")
    personne.get("instrument") ==> NONE
  
    # itererer sur la map
  
    for i in personne:
    print(f"clef={i} - valeur={personne[i]}")
  </pre>

- supprimer une clé/Valeur:
  <pre>
    notes = {"math": 15, "francais": 12, "anglais": 14}
    # supprimer une valeur
    deletedValue = notes.pop("francais")
  </pre>

### Compréhension de liste:

- permet de créer facilement une liste à partir d'une autre liste
  - condition à droite : permet de décider si on ajoute l'élément à la nouvelle liste
    <pre>
      noms = ["Jean", "Sophie", "Martin", "John", "Joe", "Jack", "Martin"]
      longeurs_noms = [e for e in noms if len(e) > 5]
    </pre>
  - condition à gauche : permet de dire quel sera la valeur de l'élément
    <pre>
      noms = ["Jean", "Sophie", "Martin", "John", "Joe", "Jack", "Martin"]
      longeurs_noms = [len(e) if len(e)>5 else 0 for e in noms]
    </pre>
- créer une liste à partir de rien
  <pre>
    # liste de nombre pair
    a = [i for i in range(0,5) if i%2 == 0]
    # liste des nombres de 0 à 10 en indiquant s'ils sont pair
    a = [(i, True if i%2 == 0 else False) for i in range(0,10)]
  </pre>

### Any / All

- Any : retourne True, quand au moins un des éléments a rempli le critère True
- All : retourn True, quand tous les éléments sont True
  <pre>
    # savoir si liste contient au moins un nom avec le caractère "z"
    noms = ["Jean", "Sophie", "Martin", "John", "Joe", "Jack", "Martin","Zoe"]
    noms_z = any([True if "z" in e.lower() else False for e in noms])
  </pre>

### zip

- permet d'aggréger des données de différentes listes dans une nouvelle liste de tuples
- tuple: une valeur de chaque liste (condition: les listes doivent avoir la même taille)
- il faut utiliser la fonction 'list' pour pouvoir afficher les valeurs de l'objet zip
  <pre>
    pizza_nom = ["Calzone","4 fromages","Paysanne"]
    pizza_prix = [10.5,12.6,15.4]
    pizza_nom_prix = list(zip(pizza_nom, pizza_prix))
    print("pizza_nom_prix = ", pizza_nom_prix)
    ==> result:
    pizza_nom_prix =  [('Calzone', 10.5), ('4 fromages', 12.6), ('Paysanne', 15.4)]
  </pre>
  <pre>
    list_pizza_init = (list(zip(*pizza_nom_prix)))
    print(list_pizza_init[0])
    print(list_pizza_init[1])
    ==> result
    ('Calzone', '4 fromages', 'Paysanne')
    (10.5, 12.6, 15.4)
  </pre>
- zip et chaine de caracètre :
  <pre>
  rows = ["Gildas","mammax"]
  zipRows = list(zip(*rows))
  print(zipRows)
  ==> 
  result : 
  [('G', 'm'), ('i', 'a'), ('l', 'm'), ('d', 'm'), ('a', 'a'), ('s', 'x')]
  </pre>

### set

- collection à valeur unique sans notion d'order
- le set peut être énuméré
  <pre>
    for s in set_noms:
      print(s)
  </pre>
- le set ne peut être indexé
- pour l'indexation, il faut transformer le set en list
  <pre>
  noms = ["Marie", "Paul", "Jean", "Marc", "Emilie", "Marie"]
  set_noms = set(noms)
  print(set_noms)
  ==> result
  {'Marc', 'Marie', 'Emilie', 'Jean', 'Paul'}
  print(set_noms[0])
  ==> result: 
  Erreur
  # liste à valeur unique
  list_noms = list(set_noms)
  print(list_noms)
  print(list_noms[0])
  ==> result:
  ['Marc', 'Marie', 'Jean', 'Emilie', 'Paul']
  Marc
  </pre>

### map

- permet d'appliquer une fonction à chaque item d'un iterable(list, tuple)
- retourne un objet iterator
- idéal pour faire de la conversion de données
<pre>
  str_values = "1,2,6,9,-9,-8,8,-2,7"
  values = list(map(int, str_values.split(",")))
  print(values)
  ==> result
  [1, 2, 6, 9, -9, -8, 8, -2, 7]
</pre>

### enumerate

- permet d'ajouter un compteur à l'itération d'une liste
<pre>
animaux = ('chien', 'chat', 'lapin')
for count, e in enumerate(animaux, start=1):
    print(count, e)
==> result
1 chien
2 chat
3 lapin
</pre>

## POO

### définition

#### principe

- s'oppose à la programmation impérative/procédurale
- code plus modulaire et évolutif
- réduire les dépendances
  - organiser le code en partie indépendante
  - facilement réutilisables
- objet pour structurer et organiser le code
  - stocker et organiser les données
  - stocker et organiser les actions sur l'objet
    et donc sur les infos qu'il porte
    Exemple : Classe Personne / Actions: SePresenter(), DemanderNom()
- actions : fonctions qui sont dans la classe
  il s'agit des méthodes de la classe qui ont accès aux données de la classe

#### Relation données / actions

- En programmation impérative, il y a une décorrélation entre les fonctions et les données
- En orienté objet, on combine les actions et les données

  les fonctions accèdent à certaines données en fonction de l'entité

#### programmation impérative / procédurale

- dérouler une suite d'instruction à l'aide de fonction
  Exemple : une recette
  - oeuf = donnée
  - méthode: casserOeuf(oeuf)

### programmation oo

- création d'objet pour organiser le code
  Exemple: recette
  - oeuf = objet qui contient les données
  - méthode: casser() sur l'objet oeuf

### Class

#### constructeur: \_\_init\_\_

##### principe

- créer un objet en mémoire et le place dans self

##### self

###### principe

- le self, c'est ce qui est récupéré quand l'objet est instancié
- le self est un paramètre spécial, il est créé automatiquement

  <pre>
    # création de la classe
    class EtreVivant:
        def __init__(self, nom):
            self.nom = nom
            
        def afficher_infos(self):
            print("Je suis un Etre Vivant")
  
        def se_presenter(self):
          print("Bonour, je m'appelle ", self.nom)
  
    # instanciation de l'objet
    etreVivant = EtreVivant()
    => etreVivant = self // objet en mémoire
  
  </pre>

###### variable d'instance

- définit dans le constructeur :
  on accède au variable d'instance via self
- une variable différente par instance

###### méthode d'instance

- méthode qui permet de travailler sur l'objet
- une méthode d'instance se voit automatiquement attribué le paramètre self
<pre>

  # le code suivant
  personne.sePresenter()

  # est équivalent au code
  Personne.sePresenter(self)

</pre>
### variable de classe

- définit au niveau de la classe
- une variable pour toutes les instances
- en minuscule pour différencier des constantes ou en majuscule comme les constantes
- Pour y accéder:
  - Class.variable_classe
  - self.variable_classe
    => car c'est qd même une propriété de l'objet mais la variable est commune

#### important

- la variable de classe peut se transformer en variable d'instance
- Python créé une copie de la variable de classe pour chaque instance
  - on peut donc gérer une valeur différente par instance mais sans altérer la variable de classe

### Pattern Factory

- Créer l'entité depuis des datas sans passer directement par le constructeur
- C'est un constructeur personnalisé
- On implémente une méthode de classe qui doit créer l'entité à partir des datas
<pre>
    def fromDatas(datas):
        return Personne(datas[0], datas[1])
    ==>
    datas=("Jean", 20)
    personne1 = Personne.fromDatas(datas)
    personne1.se_presenter()
</pre>

### Dictionnaire

### Utils

- isInstance : pour checker le type d'une donnée
  <pre>
    age = 0
    if isInstance(age, int):
      ...
  </pre>

### Polymorphisme

- capacité d'un objet (Voiture => Voiture essence, Voiture eléctique...) à prendre plusieurs formes
- même code pour des objets ayant des types différents
- lié à l'héritage

* utilisation

- mettre des types différents dans une liste
- appeler des méthodes communes sur les différents objets

### Héritage

- un chat est un être vivant
- une personne est un être vivant
  ==> Le code commun aux deux classes doivent être mutualisé dans une classe parente
- Les classe enfant/dérivées peuvent au besoin:
  - définir ses propres méthodes
  - redéfinir des méthodes déjà existantes dans la classe parente
- L'héritage c'est un peu comme si on copiait le code de la classe parente de manières implicite
  - on crée une classe fille et une classe parente

#### Classe parente: super()

- appeler la classe parente via le super()
  - un peu comme le self mais pour le parent
- dans une méthode
- dans le constructeur
  <pre>
    # héritage simple
    class Etudiant(Personne):
  
    def __init__(self, nom, etudes:tuple):
        super().__init__(nom)
        self.etudes = etudes
  
    def se_presenter(self):
        super().se_presenter()
        print(f"Je suis etudiant en " + str(self.etudes))
  </pre>
  <pre>
  # Avec Héritage multiple
    class Etudiant(Personne, Predateur):
  
        def __init__(self, nom, etudes:tuple, dents=0):
            Personne.__init__(self, nom)
            Predateur.__init__(self, dents)
            self.etudes = etudes
  
        def se_presenter(self):
            super().se_presenter()
            print(f"Je suis etudiant en " + str(self.etudes))
            print(f"Je suis un predateur " + str(self.dents))
  </pre>

### Héritage multiple

- hériter de plusieurs classes parentes
- ajouter d'autres caractérisitques comme Predateur pour un etre vivant
- commme si on concatène les méthodes et variables des classes parentes
  pour les mettre dans une seul et même classe
- Question : pour le constructeur
  - faut-il redéfinir le constructeur avec les variables des deux classes?
- Exemple: ce qui donne :

  <pre>
  class EtreVivant:
      def __init__(self, nom):
          self.nom = nom
      def afficher_infos(self):
          print("Je suis un Etre Vivant")
  
  class Predateur:
      def __init__(self, dents):
          self.dents = dents
  
      def chasser_et_manger_proie(self):
          print("miam miam")
  
  class Lion(EtreVivant, Predateur):
      def __init__(self, nom, dents=10):
          self.nom = nom
          self.dents = dents
  
      def afficher_infos(self):
          print(f"Je suis un lion, mon nom est {self.dents}")
          print(f"J'ai {self.dents} dents")
  
  class Personne(EtreVivant):
      def afficher_infos(self):
          print("Je suis une personne")
  
  lion = Lion(nom="toto",dents=10)
  lion.afficher_infos();
  lion.chasser_et_manger_proie()
  </pre>

### Comparaison d'objet

- que signifie avoir deux objets identiques entre eux ?
- is : comparaison d'instance (compare si c'est le même objet)
- == : comparaison d'égalité
  - type primitif : comparaison de valeur
  - objets : par défaut comparaison d'instance

#### \_\_eq\_\_

- permet de redéfinir le comparateur d'égalité
  <pre>
  class Personne(EtreVivant):
      def __init__(self, nom, age):
          self.nom = nom
          self.age = age
  
      def __eq__(self, other):
          return self.nom == other.nom and self.age == other.age
  </pre>

#### dictionnaire

- astuce pour comparer deux objets quand on ne peut pas redéfinir le comparateur d'égalité
  <pre>
  personne1 = Personne("Jean", 20)
  personne2 = Personne("Jean", 20)
  
  print(personne1.__dict__)
  print(personne2.__dict__)
  print(personne2.__dict__ == personne1.__dict__)
  ==> 
  {'nom': 'Jean', 'age': 20}
  {'nom': 'Jean', 'age': 20}
  True
  </pre>

### Copie d'objet

- shallow copy

  - copie des valeurs mais pas des références
    <pre>
      personne1 = Personne("Jean", 20, ["Claire","Marc","Emilie"])
      personne2 = copy.copy(personne1)
      personne1.amis[0] = "Pascal"
      personne1.afficher_infos()
      personne2.afficher_infos()
      print(personne1 is personne2)
      ==> result
      Je suis une personne
      amis['Pascal', 'Marc', 'Emilie']
      Je suis une personne
      amis['Pascal', 'Marc', 'Emilie']
      False
    </pre>

- deep copy
  - copie des valeus et des références
  <pre>
    personne1 = Personne("Jean", 20, ["Claire","Marc","Emilie"])
    personne2 = copy.deepcopy(personne1)
    personne1.amis[0] = "Pascal"
    personne1.afficher_infos()
    personne2.afficher_infos()
    print(personne1 is personne2)
    ==> result
    Je suis une personne
    amis['Pascal', 'Marc', 'Emilie']
    Je suis une personne
    amis['Claire', 'Marc', 'Emilie']
    False
  </pre>

### \_\_str\_\_ et \_\_repr\_\_

#### \_\_str\_\_

- représentation texte de l'objet
- peut être redéfini et doit retourner une chaine de caractère
<pre>
    def __str__(self):
        return __class__.__name__ + " " + str(self.__dict__)
</pre>

#### \_\_repr\_\_

- information pour le développeur dans le debuggueur
  <pre>
      def __repr__(self):
          return "REPR"
  </pre>

### Méthodes d'instances, de classe et statiques

#### Méthode statique : @staticmethod

- ne dépend pas de l'instance et des variables d'instance
- une méthode statique peut accéder à la classe:
  ==> on peut accéder au variable de classe
  Personne.TYPE
- Le décorateur permet d'appeler la méthode à partir de l'instance
  <pre>
    class Personne(EtreVivant):
      # variable de classe
      TYPE="Humain"
  
      def __init__(self, nom):
          self.nom = nom
  
      def afficher_infos(self):
          print("nom : " + Personne.formatte_chaine(self.nom) + " - TYPE : " + self.TYPE)
  
      @staticmethod
      def formatter_chaine(a):
          return a[0].upper() + a[1:].lower()
  
    personne1 = Personne("jean")
    print(Personne.formatter_chaine("toTO"))
  </pre>

#### Méthode de classe : @classmethod

- identique à méthode statique mais
  permet d'accèder à la classe sour la forme d'un paramètre
- Le décorateur permet d'appeler la méthode à partir de l'instance

* récupère la classe : cls
  cls => comme si on avait ecrit le nom de la classe (ex: Personne)
  <pre>
    @classmethod
    def methode_classe(cls):
        print("methode de clase ", cls.formatter_chaine("toTO"))
  </pre>

### Modificateur d'accès

- on utiliser le '\_' pour les modificateurs private et protected
- en python, c'est une convention
- cela signifie que l'on ne doit pas modifier ces variables depuis l'extérieur

#### public

- par défaut, c'est le statut
- accès depuis l'intérieur et l'exterieur de la classe

#### private (\_\_a)

- utilisation juste à l'intérieur de la classe
  - variable qui sont là pour le fonctionnement interne de la classe
- on préfixe la variable avec 2 underscore: \_\_nom
- il faut le voir comme une convention car ce n'est pas stricte

  - définit une nouvelle variable : \_Personne\_\_nom qui peut être modifié de l'extérieur
    <pre>
      class Personne(EtreVivant):
          def __init__(self, nom):
              self.__nom = nom
      
          def afficher_infos(self):
              print("infos : " + str(self.__dict__))
    
      personne1 = Personne("jean")
      personne1.afficher_infos()
      ==> result
      infos : {'\_Personne\_\_nom': 'jean'}
      </pre>

#### protected (\_a)

- accès à la variable depuis les classe dérivées et depuis l'intérieur
- <pre>
    class Personne(EtreVivant):
        def __init__(self, nom):
            self._nom = nom
  
        def afficher_infos(self):
            print("infos : " + str(self.__dict__))
  
  
    class Etudiant(Personne):
        def se_presenter(self):
            print(f"Je suis etudiant : " + self._nom)
  
    personne1 = Etudiant("jean")
    personne1.se_presenter()
    ==> Result
    Je suis etudiant jean
  </pre>
