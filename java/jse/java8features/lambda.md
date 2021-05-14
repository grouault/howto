## Lambda

## urls
https://www.jmdoudoux.fr/java/dej/chap-lambdas.html

#lambdas-4
https://www.baeldung.com/java-8-functional-interfaces
https://www.baeldung.com/java-8-lambda-expressions-tips
https://www.baeldung.com/java-8-sort-lambda
https://docs.oracle.com/javase/tutorial/java/javaOO/methodreferences.html

### Définition
* Hormis les instructions et données primitives, tout est objet en Java: classe, méthode...
* Java ne propose pas de définir 'Fonction/Méthode' en dehors des classes, ni de pousser une telle fonction en <b>parmètre d'une méthode</b>.
* Le seul moyen est d'utiliser une classe anonyme : exemple sur un constructeur

```
Thread monThread = new Thread(new Runnable() {
  @Override
  public void run(){
    System.out.println("Mon traitement ");
  }
});
monThread.start();
```

* Une lambda est une <b>closure</b> ou <b>fonction anonyme</b> dont le but principal est de <b>passer en paramètre</b> un certains nombre de <b>traitements</b>.


### Programmation Fonctionnelle
* Les lambdas permettent la <b>programmation fonctionnelle</b>.
* Ainsi, le code prend en charge des <b>méthodes</b> qui prennent en <b>paramètre</b> une <b>interface fonctionnelle</b>.
* Dans ce mode de programmation, le résultat est décrit par la façon dont les traitements sont réalisés.
Ceci permet de réduire la quantité de code à produire pour le même résultat:

```
list.foreach(System.out:println)
```
<pre>
Dans le code précédent, on évite la boucle for et le code associé.
</pre>

### Expression lambda
* Une expression lambda est une <b>fonction anonyme</b> qui implémente une <b>interface fonctionnelle</b>.
* Une expression lambda correspond à une <b>méthode anonyme</b> dont le <b>type</b> est défini par une <b>interface fonctionnelle</b>.
* L'utilisation d'une expression lambda évite d'avoir à écrire le code nécessaire à la <b>déclaration</b> de la classe anonyme et de la méthode.

```
Thread monThread = new Thread(() -> { System.out.println("Mon traitement"); });
monThread.start();
```

* Une expression lambda est <b>typée</b> de manière <b>statique</b>. Ce type doit être une interface fonctionnelle.
* L'expression lambda ne contient pas elle-même non plus d'information sur l'interface fonctionnelle qu'elle implémente. Cette <b>interface</b> sera <b>déduite par le compilateur</b> en fonction de son type d'utilisation.
* Deux expressions lambda syntaxiquement identiques peuvent donc être assignée à plusieurs interfaces fonctionnelles tant qu'elle respecte leur contrat.
```
    LongFunction longFunction = x -> x * 2;
    IntFunction  intFunction  = x -> x * 2;
    Callable<String> monCallable = () -> "Mon traitement";
    Supplier<String> monSupplier = () -> "Mon traitement"; 
```

## Lambda et compilateur
* Les expressions lambdas ne sont <b>pas transformées en classe par le compilateur</b> ; elles n'utilisent donc pas les classes anonymes internes.
* Le compilateur va tenter de réaliser une <b>inférence du type</b> pour le déterminer selon le contexte.
* Une expression <b>lambda</b> sera <b>transformée</b> par le <b>compilateur</b> en une <b>instance du type de son interface fonctionnelle</b> selon le contexte dans lequel elle est définie:
	* soit celle du type de la référence à laquelle l'expression est assignée.
	* soit celle du type du paramètre à laquelle l'expression est assignée.

## Lambda et Objet
* Il est <b>impossible d'assigner une lambda</b> à une variable de <b>type Object</b> parce qu'un Objet n'est pas une interface fonctionnelle.
* On <b>assigne</b> un <b>lambda</b> à une <b>interface fonctionnelle</b>.
* Une expression lambda est définie grâce à une interface fonctionnelle : une instance d'une expression lambda qui implémente cette interface est un objet. 
* Cela permet à une expression lambda
	* de s'intégrer naturellement dans le système de type de Java
	* d'hériter des méthodes de la classes Object
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
<i>Note</i> : Attention cependant, une expression lambda ne possède pas forcément d'identité unique : la sémantique de la méthode equals() n'est donc pas garantie.

## Lambda et portée 
* Lambdas ne peut <b>pas changer</b> la <b>valeur</b> d'un <b>objet</b> du <b>scope englobant</b>
* <b>this</b>: dans un lamba, fait référence à l'<b>objet englobant</b>
* Dans le cas d'objet <b>mutable</b>, l'état peut-être changer par le lambda.
* Protéger les variables objet contre les mutations

## Bonnes pratiques

### Garder les expressions lambda courtes et explicites
* Si possible, utilisez des <b>constructions</b> d’<b>une ligne</b> au lieu d’un grand bloc de code.
* Rappelez-vous <b>lambdas</b> devrait être une <b>expression</b>, pas un récit. 
* Malgré sa <b>syntaxe concise</b>, les lambdas doivent exprimer <b>précisément</b> la fonctionnalité qu’ils fournissent.

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

  
