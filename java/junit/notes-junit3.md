
### JUNIT

[home](index-junit.md)

[source](https://www.jmdoudoux.fr/java/dej/chap-junit.htm)
## Principe.

<pre>
- Un framework pour le développement des tests unitaires reposant sur des assertions qui testent les résultats attendus.
- Le but est d'automatiser les tests. Ceux-ci sont exprimés dans des classes sous la forme de cas de tests avec leurs résultats attendus. 
- JUnit exécute ces tests et les comparent avec ces résultats.
- Cela permet de séparer le code de la classe, du code qui permet de la tester
- La rédaction de cas de tests peut avoir un effet immédiat pour détecter des bugs mais surtout elle a un effet à long terme qui facilite la détection d'effets de bords lors de modifications.
</pre>

<pre>
Avec JUnit, l'unité de test est une <b>classe dédiée qui regroupe des cas de tests</b>. 

Ces cas de tests exécutent les tâches suivantes :
- création d'une instance de la classe et de tout autre objet nécessaire aux tests
- appel de la méthode à tester avec les paramètres du cas de test
- comparaison du résultat attendu avec le résultat obtenu : en cas d'échec, une exception est levée
</pre>

## L'écriture des cas de tests.
<pre>
- JUnit propose un framework pour écrire les classes de tests.
- Un test est une classe qui hérite de la classe <b>TestCase</b>. 
- Par convention le nom de la classe de test est composé du nom de la classe suivi de Test.

- Chaque cas de tests fait l'objet d'une méthode dans la classe de tests. Le nom de ces méthodes doit obligatoirement commencer par le préfixe test.
Chacune de ces méthodes contient généralement des traitements en trois étapes :
    - Instanciation des objets requis
    - Invocation des traitements sur les objets
    - Vérification des résultats des traitements
</pre>

<pre>
<b>ATTENTION :</b> Il est important de se souvenir lors de l'écriture de cas de tests que ceux-ci doivent être indépendants les uns des autres. 
JUnit ne garantit pas l'ordre d'exécution des cas de tests puisque ceux-ci sont obtenus par introspection.
Toutes les classes de tests avec JUnit héritent de la classe Assert.
</pre>

## Définition de la classe de tests

<pre>
Pour écrire les cas de tests, il faut écrire une classe qui étende la classe :
<b>junit.framework.TestCase</B>

## Nommage de la classe de Tests et des méthodes
Le nom de cette classe est le nom de la classe à tester suivi par "Test".
Dans cette classe, il faut écrire une méthode dont le nom commence par "test" en minuscule suivi du nom du cas de test (généralement le nom de la méthode à tester).

Chacune de ces méthodes doit avoir les caractéristiques suivantes :
- elle doit être déclarée public
- elle ne doit renvoyer aucune valeur
- elle ne doit pas posséder de paramètres.
Par introspection, JUnit va automatiquement rechercher toutes les méthodes qui respectent cette convention. 
Le respect de ces règles est donc important pour une bonne exécution des tests par JUnit.
</pre>

## Définition des cas de test.

<pre>
Avec JUnit, la plus petite unité de tests est l'assertion dont le résultat de l'expression booléenne indique un succès ou une erreur.

Les cas de tests utilisent des affirmations (assertion en anglais) sous la forme de méthodes nommées assertXXX() proposées par le framework.
Bien qu'il soit possible de n'utiliser que la méthode assertTrue(), les autres méthodes assertXXX() facilitent l'expression des conditions de tests.

L'ordre des paramètres contenant la valeur attendue et la valeur obtenue est important pour obtenir un message d'erreur fiable en cas d'échec du cas de test. 
Quelque soit la surcharge utilisée l'ordre des deux valeurs à tester est toujours le même : c'est toujours la valeur attendue qui précède la valeur courante.
</pre>

### fail()
<pre>
La méthode fail() permet de forcer le cas de test à échouer. 
Une version surchargée permet de préciser un message qui sera affiché.
</pre>

## Tester une exception.

<pre>
Il est aussi souvent utile lors de la définition des cas de tests de tester si une exception est levée lors de l'exécution des tests.
Avec JUnit, pour réaliser de tels cas de tests, il suffit d'appeler la méthode avec les conditions qui doivent lever une exception, d'encapsuler cet appel dans un bloc try/catch et d'appeler la méthode fail() si l'exception désirée n'est pas levée.

Attention : une erreur courante lorsque l'on code ses premiers tests unitaires est d'inclure les invocations de méthodes dans des blocs try/catch. 
Leur utilisation doit être uniquement réservée comme dans l'exemple précédant. Dans tous les autres cas, il faut laisser l'exception se propager : dans ce cas, JUnit va automatiquement reporter un échec du test. 
Il est en particulier inutile d'utiliser un bloc try/catch et de faire appel à la méthode fail() dans le catch puisque JUnit le fait déjà.
</pre>

## SetUp/ TearDown : Initialisation des cas de tests.
<pre>
Il est fréquent que les cas de tests utilisent une instance d'un même objet ou nécessitent l'usage de ressources particulières telle qu'une instance d'une classe pour l'accès à une base de données par exemple.

Pour réaliser ces opérations de création et de destruction d'objets, la classe TestCase propose les méthodes setUp() et tearDown() 
qui sont respectivement appelées avant et après l'appel de chaque méthode contenant un cas de test.

Sa mise en oeuvre n'est donc requise que si toutes les méthodes de tests ont besoin de créer une instance d'un même type ou d'exécuter un même traitement.
Le plus simple est de définir un membre privé du type dont on a besoin et de créer une instance de ce type dans la méthode setUp().
</pre>

## TestSetup
<pre>
Pour des besoins particuliers, il peut être nécessaire d'exécuter du code une seule fois avant l'exécution des cas de tests et/ou d'exécuter du code une fois tous les cas des tests exécutés.
JUnit propose pour cela la classe junit.Extensions.TestSetup qui propose la mise en oeuvre du design pattern décorateur
</pre>

## Suite de Tests.
<pre>
Les suites de tests permettent de regrouper plusieurs tests dans une même classe. 

Ceci permet l'automatisation de l'ensemble des tests inclus dans la suite et de préciser leur ordre d'exécution.
Pour créer une suite, il suffit de créer une classe de type TestSuite et d'appeler la méthode addTest() pour chaque classe de tests à ajouter. 

Celle-ci attend en paramètre une instance de la classe de tests qui sera ajoutée à la suite. 
L'objet de type TestSuite ainsi créé doit être renvoyé par une méthode dont la signature doit obligatoirement être
   public static Test suite(). 

Celle-ci sera appelée par introspection par le TestRunner.
</pre>

<pre>
public class ExecuterLesTests {

  public static Test suite() {
    TestSuite suite = new TestSuite("Tous les tests");
    suite.addTestSuite(MaClasseTest.class);
    suite.addTestSuite(MaClasse2Test.class);
    return suite;
  }

  public static void main(String args[]) {
    junit.textui.TestRunner.run(suite());
  }
}
</pre>

## Exécution

<pre>
Compiler la classe de test avec le fichier junit.jar qui doit être dans le classpath

==> java -cp junit.jar;. junit.textui.TestRunner MaClasseTest

Les cas en échec (failures) correspondent à une vérification faite par une méthode assertXXX() qui a échoué.
Les cas en erreur (errors) correspondent à la levée inattendue d'une exception lors de l'exécution du cas de test.
</pre>

<pre>
Il est possible de définir une classe main() dans une classe de tests qui va se charger d'exécuter les tests.

public class MaClasseTest extends TestCase {
  ...
  public static void main(String[] args) {
    junit.textui.TestRunner.run(new TestSuite(MaClasseTest.class));
  }
}
</pre>

<pre>
Exécution répétée de test : junit.extensions.RepeatedTest

Exemple :

  public static Test suite() {
    return new RepeatedTest(new TestSuite(PersonneTest.class), 5);
  }


Exécution concurrente de test : junit.extensions.ActiveTestSuite
==> il faut utiliser une suite de test.
Exemple :  
  public static Test suite() {
    TestSuite suite = new ActiveTestSuite();
    suite.addTest(new TestSuite(PersonneTest.class));
    suite.addTest(new TestSuite(PersonneTest.class));
    suite.addTest(new TestSuite(PersonneTest.class));
    return suite;

  }
==>
  public static void main(String[] args) {
    junit.textui.TestRunner.run(suite());
  }
</pre>

<pre>
Même si cela n'est pas recommandé, la classe ActiveTestSuite peut être utilisée comme un outil de charge rudimentaire. 
Il est ainsi possible de combiner l'utilisation des classes ActiveTestsuite et RepeatedTest.

  public static Test suite() {
    TestSuite suite = new ActiveTestSuite();
    suite.addTest(new RepeatedTest(new TestSuite(PersonneTest.class), 10));
    suite.addTest(new RepeatedTest(new TestSuite(PersonneTest.class), 20));
    return suite;
  }
</pre>