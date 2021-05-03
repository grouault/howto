## Lambda

## urls
https://www.jmdoudoux.fr/java/dej/chap-lambdas.html
#lambdas-4
https://www.baeldung.com/java-8-functional-interfaces
https://www.baeldung.com/java-8-lambda-expressions-tips
https://www.baeldung.com/java-8-sort-lambda
https://docs.oracle.com/javase/tutorial/java/javaOO/methodreferences.html

### Définition
Hormis les instructions et données primitives, tout est objet en Java: classe, méthode...
Java ne propose pas de définir 'Fonction/Méthode' en dehors des classes, ni de pousser une telle fonction en parmètre d'une méthode.
Le seul moyen est d'utiliser une classe anonyme.
Une lambda est une closure ou fonction anonyme dont le but principal est de passer en paramètre un certains nombre de traitements.

### Programmation Fonctionnelle
Les lambdas permettent la programmation fonctionnelle.
Ainsi, le code prend en charge des méthodes qui prennent en paramètre une interface fonctionnelle.
Dans ce mode de programmation, le résultat est décrit par la façon dont les traitements sont réalisés.
Ceci permet de réduire la quantité de code à produire pour le même résultat:
```
list.foreach(System.out:println)
```
Dans ce code, on évite la boucle for et le code associé.

### Expression lambda
* Une expression lambda est une fonction anonyme qui implémente une interface fonctionnelle.
* Une expression lambda correspond à une méthode anonyme dont le type est défini par une interface fonctionnelle.
* L'utilisation d'une expression lambda évite d'avoir à écrire le code nécessaire à la déclaration de la classe anonyme et de la méthode.
* Une expression lambda est typée de manière statique. Ce type doit être une interface fonctionnelle.
* L'expression lambda ne contient pas elle-même non plus d'information sur l'interface fonctionnelle qu'elle implémente. Cette interface sera déduite par le compilateur en fonction de son type d'utilisation.
* Deux expressions lambda syntaxiquement identiques peuvent donc être assignée à plusieurs interfaces fonctionnelles tant qu'elle respecte leur contrat.
```
    LongFunction longFunction = x -> x * 2;
    IntFunction  intFunction  = x -> x * 2;
    Callable<String> monCallable = () -> "Mon traitement";
    Supplier<String> monSupplier = () -> "Mon traitement"; 
```

## Lambda et compilateur
* Les expressions lambdas ne sont pas transformées en classe par le compilateur ; elles n'utilisent donc pas les classes anonymes internes.
* Le compilateur va tenter de réaliser une inférence du type pour le déterminer selon le contexte.
* Une expression lambda sera transformée par le compilateur en une instance du type de son interface fonctionnelle selon le contexte dans lequel elle est définie:
- soit celle du type à laquelle l'expression est assignée.
- soit celle du typedu paramètre à laquelle l'expression est assignée.

## Lambda et Objet
* Il est impossible d'assigner une lambda à une variable de type Object par qu'un Objet n'est pas une interface fonctionnelle.
* On assigne un lambda à une interface fonctionnelle.
* Une expression lambda est définie grâce à une interface fonctionnelle : une instance d'une expression lambda qui implémente cette interface est un objet. Cela permet à une expression lambda
- de s'intégrer naturellement dans le système de type de Java
- d'hériter des méthodes de la classes Object
```
public class TestLambda {

  public static void main(String[] args) {
    Runnable monTraitement = () -> {
      System.out.println("mon traitement");
    };
    Object obj = monTraitement;
  }
}
```
Attention cependant, une expression lambda ne possède pas forcément d'identité unique : la sémantique de la méthode equals() n'est donc pas garantie.

## Lambda et portée 
* Lambdas ne peut pas changer la valeur d'un objet du scope englobant
* this: dans un lamba, fait référence à l'objet englobant
* Dans le cas d'objet mutable, l'état peut-être changer par le lambda.
* Protéger les variables objet contre les mutations

## Bonnes pratiques

### Garder les expressions lambda courtes et explicites
* Si possible, utilisez des constructions d’une ligne au lieu d’un grand bloc de code.
* Rappelez-vous lambdas devrait être une expression, pas un récit. 
* Malgré sa syntaxe concise, les lambdas doivent exprimer précisément la fonctionnalité qu’ils fournissent.

### Éviter les blocs de code dans le corps de Lambda
Dans une situation idéale, les lambdas doivent être écrits en une seule ligne de code. Avec cette approche, la lambda est une construction auto-explicative, qui déclare quelle action doit être exécutée avec quelles données (dans le cas de lambdas avec des paramètres).

### Éviter de spécifier des types de paramètres
Un compilateur dans la plupart des cas est capable de résoudre le type de paramètres lambda à l’aide du type 'inference'. Par conséquent, l’ajout d’un type aux paramètres est facultatif et peut être omis.

### Éviter les parenthèses autour d’un seul paramètre
La syntaxe lambda nécessite des parenthèses seulement autour de plus d’un paramètre ou lorsqu’il n’y a aucun paramètre. C’est pourquoi il est sûr de rendre votre code un peu plus court et d’exclure les parenthèses quand il n’y a qu’un seul paramètre.

### Éviter les valeurs de retour et les accolades
Les éviter pour la clareté et la consistence

### Utiliser Java 8 feature: methode reference

### Utiliser des variables finals

  