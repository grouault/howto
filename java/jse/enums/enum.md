# Links.
##
http://download.oracle.com/javase/1,5.0/docs/guide/language/enums.html

# Définitions.
##
Une enumeration java est une classe qui définit un sous ensemble de constantes dont le type est la classe elle-même.
Il est permis d'ajouter à type enum : 
- des méthodes
- des attributs

# Static méthode values();
##
- Cette méthode permet un tableau contenant tous les valeurs de l'enum.
- Utiliser en combinaison avec for-each-loop.
Exemple:
-------- 
    static {
        for (Suit suit : Suit.values())
            for (Rank rank : Rank.values())
                protoDeck.add(new Card(rank, suit));
    }

# Parameters.
## 
Chaque constante de l'énumération peut-être définit avec des paramètres.
MERCURY (3.303e+23, 2.4397e6)
Ces paramètres sont passés au constructeur au moment de la création de l'enum.
Exemple :
---------
    Planet(double mass, double radius) {
        this.mass = mass;
        this.radius = radius;
    }

# Comportement différent pour chaque constante pour une méthode.
##
1- déclarer une méthode abstraite dans la classe enum-type.
2- sucharger cette méthode avec une méthode concrète pour chaque constante.
De telles méthodes sont connues comme des méthodes spécifiques pour chaque constante.
  
# EnumSet
## 
EnumSet is a high-performance Set implementation for enums.
Enum sets support iteration over ranges of enum types.
Exemple :
    for (Day d : EnumSet.range(Day.MONDAY, Day.FRIDAY))
        System.out.println(d);
        
# EnumMap
##
If you want to map an enum to a value, you should always use an EnumMap in preference to an array.
