## constante
* pas de  constante à proprement parler mais une convention,
il faut mettre la variable en majuscule
<pre>
NOMBRE_MAGIQUE = random.randint(NOMBRE_MIN, NOMBRE_MAX)
</pre>

## if not
* négation
<pre>
if not age == 0 <==> if age != 0
# Pour un objet non défini
if not personne : 
  => //True si personne vaut None
</pre>

## None
* permet de représenter un objet vide
* initialiser un objet vide
* En retour de fonction on peut tester de la manière suivante :
<pre>
if not Objet: // Objet = False ==> not Objet = True
  // là on a obtenu un None / un objet vide
else:
  // Objet a bien une valeur
</pre>

## boucle for
* permet de boucler un nombre de fois
  * range : dans l'ensemble [inclusif, exclusif]
  <pre>
  # on boucle 4 fois en partant de 0
  for i in range(0,4):
    print i
  </pre>
* permet de boucler sur un nombre d'éléménts
  <pre>
  notes = [4,5,6,7,8]
  # toutes les notes
  for i in notes:
    print(i)
  </pre>


## incrementer / decrementer
<pre>
i += 10
i -= 10
</pre>

## Commentaire
<pre>
# : commenter une ligne
''' ''': commenter plusieurs lignes
</pre>

## Librairie Mahtematiques
<pre>
import random
NOMBRE_MAGIQUE = random.randint(NOMBRE_MIN, NOMBRE_MAX)

moyenne = int(NB_QUESTIONS / 2)
</pre>

## Chaine de caractères
### savoir si un caractère contient une valeur
* if "e" in chaine_caractere:
  <pre>
    if "z" in nom.lower()
  </pre>
* find: chaine_caractère.find(search_chaine)
  * retourne l'index de début
  * retoure -1 si non trouvé

## Ternaire
<pre>
maximum = nb_pizza_to_show > 0 and nb_pizza_to_show or len(pizzas)
</pre>

## isdigit()
* permet de tester si le caractère est un nombre
<pre>
"1".isdigit()
</pre>

## Fonctions
### arguments vs paramètres
* paramètre d'une fonction : utilisé pour définir les paramètres
* arguments d'une fonction : utilisé pour passer des valeurs à l'appel de la fonction

### paramètres nommés
* il est possible de nommer les paramètres à l'appel d'une fonction
* il suffit de préciser le nom de l'argument
* dans ce cas, il est possible de ne pas respecter l'ordre des arguments
<pre>
def maFonction(param1, param2):
  ...

maFonction(param1=2, param2=3)
</pre>

### recuperer plusieus paramètres
* fonction qui renvoit plusieurs paramètres
<pre>
def ma_fonction():
    return 2,3

a,b = ma_fonction()
</pre>

### break vs return vs exit
* le break s'utilise dans une boucle
  * Pour arrêter l'exécution de la boucle avant la fin
  * n'arrête pas l'exéution d'une fonction comme le fait return
  * break : pas de notion de renvoi de résultat
* return
  * sortir d'une fonction
  * renvoyer une valeur
<pre>
# on boucle 4 fois en partant de 0
for i in range(0,4):
    print i
    if i == 2:
        break
</pre>
* exit
  * sert au niveau du programme principal pour arrête son exécution
  * permet de spécifier un code erreur : exit(0) | exit(1) | exit(2)
  * ce code peut-être exploiter par le programme principal ou le terminal

### récursion
* fonction qui s'appelle elle-même
* fonction bloquante: on attent la fin de la fonction appelée pour que la fonction appelante
  termine son exécution.
* Sans retour de valeur :
  * Une fonction récursive s'appelle elle-même avec une condition de sortie
  * sans condition de sortie: en boucle infinie
  <pre>
    def a(n, limit=100000):
        if n > limit:
            return
        print("n = ", n)
        a(n * n)
    
    a(2, 100000)
  </pre>
* Avec retour de valeur :
  * il faut récupérer le retour de l'appel précédent et le retourner

### callback : 
* le fait de stocker une fonction dans une variable ou passer la ref ou la fonction à une autre fonction

#### lambda : 
* fonction qui n'ont pas de nom. On a pas créer la fonction.
* permet de créer un callback
<pre>
def afficher_table(n, operateur, operation_cbk, min=0, max=10):
    for i in range(min, max):
        print(f"{n}{operateur}{i}=", operation_cbk(n, i))

afficher_table(4, "*", lambda a,b : a * b)
</pre>
* utiliser beaucoup pour les fonctions asynchrone
* permet d'enregistrer une fonction et d'exécuter du code quand la fonction asyncrhone est terminée

### plusieurs paramètres
* type énuméré : *args ==> tuple
<pre>
def somme(*nombres):
    somme = 0
    for i in nombres:
        somme += i;
    return somme

print(somme(5,2,5,2))
</pre>

* **args ==> dictionnaire(clé, valeur)
<pre>
def somme(titre, **nombres):
    print(titre)
    somme = 0
    for i in nombres.values():
        somme += i
    return somme

print(somme("somme = ", maths=5,geo=2,anglais=5,sport=2))
</pre>

## Collections

### Tableaux : Array => via librairie

### TUPLE
* immutable -> non modifiable
* -1 pour le dernier élément
<pre>
personnes = ("Mélanie","Jean","Martin","Alice")
print(type(personnes))
print(personnes[0])
print(len(personnes))
for i in range(0, len(personnes)):
    print(personnes[i])
for i in personnes:
    print(i)
</pre>

#### Chaine de caractères et tuple
* une chaine de caractère se comporte comme un tuple
<pre>
for i in personnes:
    print(i, len(i), i[0])
</pre>
* récupération de la longueur et le la première lettre des personnes

#### range et tuple
* range se comporte comme un tuple
* range est un ensemble d'éléments sur lequel on itère
<pre>
# tuple et range 
valeur = range(0,5) => créé le type (0,1,2,3,4)
print(type(valeur))
print(valeur[0])
</pre>

#### Fonction et tuple
##### destructuring sur un retour de fonction
* une fonction peut retourner un tuple que l'on peut desctructurer
<pre>
def obtenir_information():
    return "Mélanie", 32, 1.6

infos = obtenir_information()
nom, age, taille = obtenir_information()
print('infos = ', infos[0], infos[1], infos[2])
print('nom=', nom, '- age=', age, '- taille=', taille)
</pre>

##### destructuring sur les paramètres d'une fonction
* une fonction passe comme argument un tuple
* on veut destructurer le tuple au niveau des paramètres de la fonction
* Unpack du tuple: il faut ouvrir le tuple en le précédent par '*' pour
  séparer les paramètres avec une virgule
<pre>
def obtenir_information():
    return "Mélanie", 32, 1.6

def afficher_information(nom, age, taille):
    print(f"Informations: nom : {nom}, age: {age}, taille: {taille}")

infos = obtenir_information()
afficher_information(*infos)
</pre>

### LISTE : 

#### mutable 
* une liste, c'est comme un tupel avec la particularité suivante :
* une liste est modifiable: on peut ajouter/supprimer des éléments ou les modifier

#### liste vs tuple
* un tuple est plus performant au niveau de la gestion mémoire
* utiliser un tuple et le convertir en liste si besoin

#### liste et fonction
* Quand on passe une liste à une fonction, si la liste est modifiée,
  la modification est prise en compte dans le programme principale.
* A la différence d'un paramètre classique, la liste est un conteneur et on
  modifie le conteneur et non la variable
* c'est une modification par référence et non par valeur

#### méthode de liste
* append : ajouter un élément et un seul élément à la liste
* insert : insertion d'un élément à un index précis de la liste
* extend | + : ajotuer les éléments d'une autre collection à la collection courante
  <pre>
  noms = ["Jean", "Sophie", "Martin"]
  noms_supplementaires = ["Christophe","Zoe"]
  noms+=noms_supplementaires
  noms.insert(0,"Toto")
  noms.insert(1,"Titi")
  noms_add = ['Tata','Tonton']
  noms = noms_add + noms
  print("noms = ", noms)
  # Resultat: 
  noms =  ['Tata', 'Tonton', 'Toto', 'Titi', 'Jean', 'Sophie', 'Martin', 'Christophe', 'Zoe']
  </pre>
* del : supprimer un élément
* intervertir, swapper des valeurs d'une liste
  <pre>
  # intervertir deux valeurs d'une liste avec la mutli-affectation
  
  noms[0], noms[2]=noms[2],noms[0]
  </pre>
* join: joindre les éléments de la collection
  <pre>
  noms = ["Jean", "Sophie", "Martin"]
  print(",".join(noms))
  </pre>
* split: créer une liste à partir d'une chaine de caractèes
  <pre>
  a = "Jean, Martin, Francois"
  a_split = a.split(",")
  </pre>
* index:
  * retourne l'index de la première valeur trouvée dans la liste
  * retounre une exeption si non trouvée
  <pre>
  if "Jean" in a_split:
    print(a_split.index("Jean"))
  else:
      print("absent")
  </pre>
* count: compter le nombre d'occurences dans la liste
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
* find: attention 'find' fonctionne pour les chaine de caractèes mais pas pour les listes.
  * pour les listes, il faut utiliser 'index'
  
#### Tris : Sort et sorted
##### sort : tri alphabétique (ASCII) - tri inplace qui altère la liste en mémoire
  * il n'y a pas une nouvelle liste de créer
  * on a plus la liste originale
    Chaque caractère est stocké en format binaire.
    <pre>
    # Tri inverse
    pizzas.sort(reverse=True)
  
##### sorted
  * fonction qui prend en paramètres une collection et renvoit une nouvelle liste
  <pre>
    noms = ["Jean", "Sophie", "Martin"]
    nom_tries = sorted(noms, reverse=True)
    noms.sort(reverse=True)
    print(noms)
    print(nom_tries)
  </pre>

##### Tri personnalisé
* utilisé le mot key et une fonction (callback) associée qui va opérer sur chaque élément de la liste
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

#### detecter qu'un élément est dans la liste
<pre>
    # pizza => liste
    # pas besoin de boucle for
    if pizza_to_add in pizzas:
        return True
</pre>

### SLICE
* un slice s'applique sur une collection également sur les chaines de caractères
* [start:stop:step] : un slice permet de paracourir une collection avec le pattern suivant
* start : index de début
* stop : index de fin
* step : indique le pas d'itération
* un step négatif permet de commener l'itération à la fin de la collection
  <pre>
  # exemple: 
  noms[3:] : commencer à l'index 3
  noms[:3] : aller jusqu'à l'index 3
  </pre>
#### SLICE et copie de listes
* un slice créé une nouvelle liste
* un slice qui prend toutes les valeurs revient donc à faire une copie de la liste
<pre>
# Copie de liste (duplication de la liste en mémoire)
slices_noms = noms[:]
</pre>

#### SLICE et index négatif
* index négatif placé à la fin :
  * revient à supprimer des élément en partant de la fin de la liste
    <pre>
    noms[:-3] : supprime les 3 derniers éléments
    </pre>
* index négatif placé au début :
  * revient à garder les élements en partant de la fin de la liste
    <pre>
    # on ne garde que le dernier élément
    slices_noms[-1:]
    </pre>

### Dictionnary : collection clé/valeur
* le dictionnaire est mutable
* on peut ajouter des clés dynamiquement
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

### Compréhension de liste:
* permet de créer facilement une liste à partir d'une autre liste
  * condition à droite : permet de décider si on ajoute l'élément à la nouvelle liste
    <pre>
      noms = ["Jean", "Sophie", "Martin", "John", "Joe", "Jack", "Martin"]
      longeurs_noms = [e for e in noms if len(e) > 5]
    </pre>
  * condition à gauche : permet de dire quel sera la valeur de l'élément
    <pre>
      noms = ["Jean", "Sophie", "Martin", "John", "Joe", "Jack", "Martin"]
      longeurs_noms = [len(e) if len(e)>5 else 0 for e in noms]
    </pre>
  
* créer une liste à partir de rien
  <pre>
    # liste de nombre pair
    a = [i for i in range(0,5) if i%2 == 0]
    # liste des nombres de 0 à 10 en indiquant s'ils sont pair
    a = [(i, True if i%2 == 0 else False) for i in range(0,10)]
  </pre>

### Any / All
* Any : retourne True, quand au moins un des éléments a rempli le critère True
* All : retourn True, quand tous les éléments sont True
  <pre>
    # savoir si liste contient au moins un nom avec le caractère "z"
    noms = ["Jean", "Sophie", "Martin", "John", "Joe", "Jack", "Martin","Zoe"]
    noms_z = any([True if "z" in e.lower() else False for e in noms])
  </pre>