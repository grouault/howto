# REST MVC

[retour](./spring-mvc.md)

## RestController

<pre>
Avec cette annotation, le corps de la réponse est automatiquement
convertit au format texte.
Ce format est avec Spring-Boot par défaut, le format JSon.
</pre>

## ResponseEntity

<pre>
<b>ResponseEntity</b> représente une <b>réponse HTTP</b> complète gérant:
 - les en-têtes
 - le corps
 - l’état (le status). 

Alors que <b>@ResponseBody</b> met uniquement la valeur de retour dans le corps de la réponse. 
Spring gère l'en-tête et l'état.
</pre>

<a href="https://technicalsand.com/using-responseentity-in-spring/#11-responseentity-example-to-return-string-" target="_blank">Respone-Entity</a>

<a href="https://zetcode.com/springboot/responseentity/" target="_blank">Respone-Entity</a>

## Méthode Http

### @GetMapping

<a href="https://www.baeldung.com/spring-new-requestmapping-shortcuts" target="_blank">GetMapping</a>~

```
    @GetMapping(value="/books")
    public ResponseEntity<List<Book>> listBooks(){
        Book book = new Book().setTitle("Tintin au Tibet").setCategory(new Category("BD"));
        return ResponseEntity.ok(Arrays.asList(book));
        // return new ResponseEntity(Arrays.asList(book), HttpStatus.OK);
    }
```

### @PostMapping

```
    @PostMapping (value="/books")
    public ResponseEntity addBook(Book book){
        // TODO: persist

        // TODO: a utiliser
        // return ResponseEntity.created(URI.create("/book/" + book.getId())).body(book).build();
        return new ResponseEntity(book, HttpStatus.CREATED);
    }
```

### @PutMapping

```
    @PutMapping(value="/books/bookId")
    public ResponseEntity updateBook(@PathVariable("bookId") String bookId, Book book){
        // TODO: delete
        return new ResponseEntity(book, HttpStatus.OK);
    }
```

### @DeleteMapping

```
    @DeleteMapping(value="/books/{bookId}")
    public ResponseEntity deleteBook(@PathVariable("bookId") String bookId){
        // TODO: delete
        return ResponseEntity.noContent().build();
    }
```

## Validation

### traitements des erreurs

<pre>
<b>Attention</b>: côté client, on a pas forcément l'information
sur quel champ est en erreur avec le message de l'erreur.
Il faut le renvoyer au client explicitement.
Pour cela voir la partie, Gestion des exceptions
</pre>

## Gestion des exceptions

### @ControllerAdvice

<pre>
Permet d'intercepter les exceptions renvoyées par Spring.
Pour cela on créer une clase 'ExceptionResolver' qui va catcher les 
exceptions de l'application avec l'annotation @ControllerAdvice
Cela permet de catcher les exceptions de tous les endpoints des  contrôleurs.
Il faut le voir comme un intercepteur d'exceptions lancées par les méthodes
annotées avec @RequestMapping ou méthodes similaires Put, Post...
</pre>

### Type d'erreurs

#### Erreurs de validation Spring

##### MethodArgumentNotValidException

<pre>
Le but est de traiter les exceptions de type:
MethodArgumentNotValidException
</pre>

##### Code

<pre>
@ControllerAdvice
public class ExceptionResolver {

    @ExceptionHandler
    public ResponseEntity handleValidationException(
            MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        // getBindingResult(): permet de traiter toutes les annotations
        // @NotNull, @Size...
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError)error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return new ResponseEntity(errors, HttpStatus.BAD_REQUEST);
    }

}
</pre>

## Swagger

### principe

<pre>
* permet de documenter automatiquement les APIs
* permet de documenter automatiquement de tester les APIs
</pre>

### url

<pre>
host/swagger-ui/index.html
</pre>

### pom.xml

```
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-ui</artifactId>
    <version>1.5.12</version>
</dependency>
```
