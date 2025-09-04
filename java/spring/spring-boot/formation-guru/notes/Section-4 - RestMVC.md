```java
public List<Beer> listBeers() {  
    return new ArrayList<>(beerMap.values());  
}
```

## docs
https://technicalsand.com/using-responseentity-in-spring/#3-what-is-requestentity-in-spring
## Méthode de requête HTTP

### GET
### POST
* est une requête de création de ressource
* status
	* 201 - avec la nouvelle ressource
	* 201 avec un corps vide mais il faut un en-tête HTTP avec la valeur de la location.
		
### PUT
* Le verbe `PUT` est utilisé pour **remplacer ou mettre à jour entièrement** une ressource existante (ou parfois en créer une si elle n’existe pas, selon l’API).
* 
📦 **Codes de statut HTTP les plus utilisés**

| Code              | Quand l’utiliser ?                                                           |
| ----------------- | ---------------------------------------------------------------------------- |
| `200 OK`          | ✅ La ressource a été **mise à jour avec succès** et tu renvoies son contenu. |
| `204 No Content`  | ✅ La ressource a été **mise à jour**, mais **aucun contenu** n’est renvoyé.  |
| `201 Created`     | ✅ Une nouvelle ressource a été **créée** via PUT (cas rare mais possible).   |
| `400 Bad Request` | ❌ Données invalides dans la requête (ex. : champs manquants ou malformés).   |
| `404 Not Found`   | ❌ La ressource à mettre à jour **n’existe pas** (selon la logique métier).   |
| `403 Forbidden`   | ❌ L'utilisateur n’a **pas les droits** de modifier la ressource.             |
Dans les deux cas, il est bon de renseigner l'objet Location

```java
@PutMapping("/users/{id}")
public ResponseEntity<Void> updateUser(@PathVariable Long id, @RequestBody UserDto userDto) {
    if (!userService.existsById(id)) {
        return ResponseEntity.notFound().build(); // 404
    }

    userService.updateUser(id, userDto);
    return ResponseEntity.noContent().build(); // 204
}
```

### PATCH
🔹 Qu'est-ce que `PATCH` ?
- `PATCH` est une méthode HTTP utilisée pour **mettre à jour partiellement** une ressource.
- Contrairement à `PUT` (qui remplace toute la ressource), `PATCH` permet de **modifier seulement certains champs**.
- 
📦 **Quand utiliser `PATCH` ?**

| Utilisation                      | Exemple                                         |
| -------------------------------- | ----------------------------------------------- |
| Modifier uniquement un nom       | `PATCH /users/42` avec `{"name": "Alice"}`      |
| Mettre à jour un statut          | `PATCH /orders/99` avec `{"status": "shipped"}` |
| Mise à jour partielle d’un objet | ✅ Au lieu d’envoyer tout l’objet                |

🚦 **Codes HTTP utilisés avec PATCH**

| Code              | Signification                   |
| ----------------- | ------------------------------- |
| `200 OK`          | Mise à jour avec réponse        |
| `204 No Content`  | Mise à jour sans contenu retour |
| `400 Bad Request` | Données invalides               |
| `404 Not Found`   | Ressource non trouvée           |
| `403 Forbidden`   | Accès refusé                    |
|                   |                                 |

### DELETE
* est une requête de suppression de ressource
* il est préférable de mettre l'id de la ressource dans l'URL car chaque ressource doit avoir une url unique.
✅ Réponse REST conventionnelle pour DELETE
 🔸 **204 No Content**
- ✅ Suppression réussie.
- ✅ Aucune donnée dans la réponse.
- ✅ C’est **la pratique REST recommandée**.
```java
@DeleteMapping("/{id}")
public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
	if (!userService.existsById(id)) {
		return ResponseEntity.notFound().build(); // 404
	}

	userService.deleteById(id);
	return ResponseEntity.noContent().build(); // 204
}
```    

📌 Autres codes possibles dans certains cas

|Code|Quand l'utiliser|
|---|---|
|`200 OK`|Si tu veux renvoyer un message de confirmation ou des détails.|
|`202 Accepted`|Si la suppression est **asynchrone** (elle aura lieu plus tard).|
|`404 Not Found`|Si la ressource à supprimer **n’existe pas**.|
|`403 Forbidden`|Si l'utilisateur **n’a pas le droit** de supprimer la ressource.|


## @RestController
* indique à Spring de traiter le contrôleur comme un contrôleur REST et de renvoyer le corps de réponse approrié (du JSON et non du HTML). La réponse est envoyé au gestionnaire de vue qui sera Jackson pour produire la réponse JSON.
* @RestController est effectivement une annotation d'aide qui combine @Controller et @ResponseBody. Cela signifie que toute méthode de ce contrôleur renverra directement des données au format JSON, simplifiant ainsi le processus de création d'API REST en évitant de devoir ajouter l'annotation @ResponseBody à chaque méthode.

## Spring - Methodes HTTP

## HTTP - Request

### @RequestMapping
* faire correspondre l'API définit au besoin souhaité.

### @PathVariable
* permet de passer une valeur dans le chemin et de la faire correspondre à une variable du context Spring.

```java
@AllArgsConstructor  
@Slf4j  
@RestController  
@RequestMapping("/api/v1/beer")  
public class BeerController {  
  
    private final BeerService beerService;  
  
    @RequestMapping(method = RequestMethod.GET)  
    public List<Beer> getBeers() {  
        return beerService.listBeers();  
    }  
  
    @RequestMapping(value = "/{beerId}", method = RequestMethod.GET)  
    public Beer getBeerById(@PathVariable("beerId") UUID beerId) {  
        log.debug("Get Beer by id in controller - beerId = {}", beerId);  
        return beerService.getBeerById(beerId);  
    }  
  
}
```

### @PostMappfing - @RequestBody
dit à Spring de faire en sorte que le corps de la requête soit posté sur l'objet
```java
@PostMapping()  
public ResponseEntity<Beer>  createBeer(@RequestBody Beer beer) {  
    Beer savedBeer = beerService.create(beer);  
    HttpHeaders httpHeaders = new HttpHeaders();  
    httpHeaders.add("location", "/api/v1/beer/" + savedBeer.getId());  
    return new ResponseEntity(savedBeer, httpHeaders, HttpStatus.CREATED);  
}
```

### @PutMapping


```java
@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PatchMapping("/{id}")
    public ResponseEntity<User> patchUser(@PathVariable Long id, @RequestBody Map<String, Object> updates) {
        try {
            User updatedUser = userService.updatePartial(id, updates);
            return ResponseEntity.ok(updatedUser); // 200 OK
        } catch (NoSuchElementException e) {
            return ResponseEntity.notFound().build(); // 404
        }
    }
}

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PatchMapping("/{id}")
    public ResponseEntity<User> patchUser(@PathVariable Long id, @RequestBody Map<String, Object> updates) {
        try {
            User updatedUser = userService.updatePartial(id, updates);
            return ResponseEntity.ok(updatedUser); // 200 OK
        } catch (NoSuchElementException e) {
            return ResponseEntity.notFound().build(); // 404
        }
    }
}

@Service
public class UserService {
    private final Map<Long, User> users = new HashMap<>();

    public Optional<User> findById(Long id) {
        return Optional.ofNullable(users.get(id));
    }

    public User updatePartial(Long id, Map<String, Object> updates) {
        User user = users.get(id);
        if (user == null) {
            throw new NoSuchElementException("User not found");
        }

        updates.forEach((key, value) -> {
            switch (key) {
                case "name" -> user.setName((String) value);
                case "email" -> user.setEmail((String) value);
            }
        });

        return user;
    }
}

```


### RequestEntity
* objet qui permet de wrapper le bean sur une méthode Post notamment
* permet de donner la main sur les données de la request : HTTP headers, HTTP method, url, request type and request body
```java
@PostMapping()  
public ResponseEntity<Beer>  createBeer(RequestEntity<Beer> requestEntity) {  
    log.info("Request entity - headers {}", requestEntity.getHeaders());  
    log.info("RequestEntity method {}", requestEntity.getMethod());  
    log.info("RequestEntity URL {}", requestEntity.getUrl());  
    log.info("RequestEntity Type {}", requestEntity.getType());  
    log.info("RequestEntity body {}", requestEntity.getBody());  
    Beer savedBeer = beerService.create(requestEntity.getBody());  
    HttpHeaders httpHeaders = new HttpHeaders();  
    httpHeaders.add("location", "/api/v1/beer/" + savedBeer.getId());  
    return new ResponseEntity(savedBeer, httpHeaders, HttpStatus.CREATED);  
}
```

## HTTP - Response - Paramètres 

### ResponseEntity
permet de customiser la réponse pour enrichir les données de réponse.
### httpHeaders

#### exemple
```java
HttpHeaders httpHeaders = new HttpHeaders();  
httpHeaders.add("location", "/api/v1/beer/" + savedBeer.getId());  
return new ResponseEntity(savedBeer, httpHeaders, HttpStatus.CREATED);

ou idem

HttpHeaders httpHeaders = new HttpHeaders();  
return ResponseEntity  
            .created(URI.create("/api/v1/beer/" + savedBeer.getId()))  
            .headers(httpHeaders)  
            .build();

ou en modification

HttpHeaders httpHeaders = new HttpHeaders();  
httpHeaders.add("Location", "/api/v1/" + customerId.toString());  
return ResponseEntity.noContent().headers(httpHeaders).build();
```
#### Location
pratique courante lorsque l'on créé un objet pour fournir une valeur en retour.
On peut renvoyer un 201 avec un corps vide mais il faut un en-tête HTTP avec la valeur de la location.
#### Content-Type
* par défaut le content-type qui sera renvoyé sera celui demandé par le client (headers client : Accept)

### HttpClient => IntelliJ
* permet de lancer des requêtes REST.
```cmd
GET http://localhost:8080/api/v1/beer/a1a0f224-f883-427f-9f0d-37412af6b402  
Accept: application/json  
  
<> 2025-04-04T161909.200.json  
<> 2025-04-04T161828.200.json  
<> 2025-04-04T161819.404.json
```