#
##
https://www.baeldung.com/java-8-streams-introduction
https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html

https://winterbe.com/posts/2014/07/31/java8-stream-tutorial-examples/
https://www.baeldung.com/java-8-streams

## source
https://github.com/eugenp/tutorials/tree/master/core-java-modules/core-java-streams-2/src/main/java/com/baeldung/reduce/application

# STREAM
Stream functionality contains classes for processing sequences of elements
A stream() default method is added to the Collection interface and allows creating a Stream<T> 
using any collection as an element source
Stream<String> stream = list.stream();

# Stream API
## Stream Creation
Stream.of( ... ) / Arrays.stream( arr ) / collection.stream()

## Multi-Threading
The code below allows to run method doWork() 
in parallel for every element of the stream :
list.parallelStream().forEach(element -> doWork(element));

## Stream-Operation
Il y a plusieurs oprations qui peuvent être exécutées sur un stream
- intermediate operations: return Stream<T> allow chaining
- terminal operations: return a result of definite type
Important : il est important de noter que les opérations sur les flux
ne changent pas la source.
Exemple : 
long count = list.stream().distinct().count();
distinct => intermediate operation
count => terminal operation

Liste des opérations :
----------------------
- Iterating
- Filtering
- Mapping
- Matching
- Reduction
- Collecting

## Iterating
- Permet de se substituer aux boucles: for, for-each, while.
Le but est de se concentrer sur la logique de l’opération, 
mais pas sur l’itération sur la séquence d’éléments.
==> animals.stream().anyMatch( a -> ... );
 
## Filtering
- La méthode filter() permet de choisir parmi un flux d’éléments, ceux qui répondent à un prédicat.

## Mapping
- conversion : pour convertir les éléments en leur appliquant une fonction spécial (de conversion) et
pour récupérer les éléments dans un nouveau Stream.

## Matching
- anyMatch(), allMatch(), noneMatch().
==> Stream API donne un ensemble pratique d’instruments pour valider les éléments d’une séquence 
selon un certain prédicat

## Reduction

