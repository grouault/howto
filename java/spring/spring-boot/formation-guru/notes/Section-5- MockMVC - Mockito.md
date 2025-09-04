
## Test

### Test unitaire
* doivent être unitaire et très rapide
* ne doivent pas avoir de dépendance au contexte (serveur web / base de données)
* teste une méthode ou une fonction

### Test d'intégration
*  conçu pour tester les comportements entre les objets
* scope plus large, les tests sont axés sur la composition et les parties du système global
* peut inclure le context spring, database ou un message broker

### Test fonctionnel
* tests automatisés effectués sur l'application
* l'application est mise en place et déployée d'une manière ou d'une autre et les points fonctionnels sont traités à travers ce système.
## MockMVC
* le contrôleur a une dépendance forte au cadre / framework Spring 
* le contrôleur a un haut degré d'intégration avec le cadre Spring MVC car le framework réalise beaucoup de travail avec la requêté (détermine sa nature Get, Post..., les variables.., le format)
* le contrôleur a des dépendance fortes aussi vers les classes de service 

### Principe
* Spring MockMVC permet de tester les interactions du contrôleur dans un contexte de servlet sans que l’application ne s’exécute sur un serveur d’applications.
* Spring MockMVC est un environnement de test spécifique pour les contrôleurs Spring MVC fournissant un simulacre de l'environnement d'exécution des servlets permettant d'obtenir une requête Http fictive, une réponse fictive et une servlet de distribution.
* MockMVC ne fait que mocker le contexte MVC mais pas le context Spring par ailleurs.
* Le mock peut être exécuté avec ou sans context Spring ; s'il faut un contexte, ce dernier sera à paramétrer avec Mockito (pour faire un mock des éléments de Service par exemple).

### @WebMvcTest
* est Test Splice Spring Boot qui créé un environnement MockMVC pour le contrôleur
* attention: les dépendances du contrôleur ne sont pas créées.
* ajouter une dépendance à l'autoloader pour simuler MVC
* intégration d'un composant MVC fictif dans le test qui sera câblé, injecté automatiquement par le cadre Spring (@autowired).
* plus besoin d'injecter le contrôleur qui sera créer avec le mock MVC
```java
@WebMvcTest(BeerController.class)  
class BeerControllerTest {  
  
    @Autowired  
    MockMvc mockMvc; // composant MVC fictif qui sera câble par Spring
    
    @MockitoBean  
    BeerService beerService;  
  
    @Test  
    void getBeerById() throws Exception {  
        mockMvc.perform(get("/api/v1/beer/" + UUID.randomUUID())  
                .accept(MediaType.APPLICATION_JSON))  
                .andExpect(status().isOk());  
    }  
  
}
```

### import static
```java
import static org.assertj.core.api.Assertions.assertThat;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
```

## Mockito

### principe

### @MockitoBean
* indique à mockito de fournir un simulacre dans le contexte Bean
* permet de créer des dépendances / beans fictifs notamment pour simuler les services dans le contexte Spring. Le service est alors créer en tant que mock Mockito et par défaut ils renvoient une réponse nulle.
* La réponse est configurable et c'est le but ; il faut configuré le mock pour lui dire ce qu'il doit retourné sur les appels de ces méthodes.
* avec le mock, on peut contrôler les arguments (Argument captors / matcher) pour vérifier qu'ils ont été parsés correctement et sont bien récupérés au niveau du contrôleur et bien passés au service.

### GIVEN : contexte de Mockito
Par défault la réponse de Mockito est nulle. Il faut donc définir un contexte de réponse pour Mockito.
```java
@Test  
void testGetBeerById() throws Exception {  
    // GIVEN  
    Beer testBeer = beerServiceImpl.listBeers().get(0);  
    given(beerService.getBeerById(any(UUID.class))).willReturn(testBeer);  
    // THEN - WHEN  
    mockMvc.perform(get("/api/v1/beer/" + UUID.randomUUID())  
            .accept(MediaType.APPLICATION_JSON))  
            .andExpect(status().isOk())  
            .andExpect(content().contentType(MediaType.APPLICATION_JSON));  
}
```
La réponse customisé :
```json
MockHttpServletRequest:
      HTTP Method = GET
      Request URI = /api/v1/beer/610ce595-b0e1-4ce6-9007-01750cbaaad5
       Parameters = {}
          Headers = [Accept:"application/json"]
             Body = null
    Session Attrs = {}

MockHttpServletResponse:
           Status = 200
    Error message = null
          Headers = [Content-Type:"application/json"]
     Content type = application/json
             Body = {"id":"9d527da8-1746-42c5-978f-52fba19eb8c3","version":1,"beerName":"Crank","beerStyle":"PALE_ALE","upc":"12356222","quantityOnHand":392,"price":11.99,"createdDate":"2025-04-06T21:51:21.3850599","updateDate":"2025-04-06T21:51:21.3850599"}
    Forwarded URL = null
   Redirected URL = null
          Cookies = []
```

###import static
```java
import static org.mockito.BDDMockito.given;
import static org.mockito.ArgumentMatchers.any;
```

### Verify
`verify(...)` permet de **vérifier qu’une méthode d’un mock a été appelée**, et les **matchers** permettent de contrôler **les arguments** de cet appel.
🧱 **Structure de base**
```java
verify(mock).method(matcher1, matcher2, ...);
```
- `verify(mock)` : vérifie qu’une méthode a été appelée.
- `method(...)` : la méthode cible.
- `matcherX` : permet de **tester les arguments** sans se baser uniquement sur des valeurs exactes.

🔧 **Exemples concrets**

```java
// Vérifier un appel avec des valeurs spécifiques
// `eq("Alice")` ➜ vérifie que le premier argument est exactement `"Alice"`.
verify(userService).saveUser(eq("Alice"), eq("admin"));

// Vérifier un appel avec n’importe quelle valeur
verify(userService).saveUser(anyString(), eq("admin"));

// Vérifier un appel avec une condition personnalisée
// `argThat(...)` ➜ vérifie que l’argument respecte une **lambda conditionnelle**.
verify(userService).saveUser(argThat(name -> name.startsWith("A")), eq("admin"));
```

| Matcher                 | Description                                    |
| ----------------------- | ---------------------------------------------- |
| `eq(value)`             | Exactement égal à la valeur                    |
| `any()`                 | N’importe quelle valeur de n’importe quel type |
| `anyString()`           | N’importe quelle `String`                      |
| `anyInt()`, `anyLong()` | Idem pour types numériques                     |
| `isNull()`              | Doit être `null`                               |
| `notNull()`             | Doit être **non-null**                         |
| `argThat(predicate)`    | Argument qui satisfait une condition lambda    |

📌 Règles importantes

| Règle                                                                                                                         |
| ----------------------------------------------------------------------------------------------------------------------------- |
| ✅ Tous les arguments doivent être des matchers **ou** des valeurs brutes, **pas un mélange**.                                 |
| ✅ Utilise `eq(...)` même pour les chaînes de caractères simples si tu utilises un autre matcher dans le même appel.           |
| ✅ `verify(...)` peut aussi prendre un second argument `times(n)` pour vérifier **combien de fois** une méthode a été appelée. |

### ArgumentCaptor
`ArgumentCaptor` est une classe de Mockito qui te permet de **capturer les arguments** passés à une méthode d’un mock pendant un test, afin de **les vérifier ensuite**.
```java
    @Test
    void testRegisterUser() {
        ArgumentCaptor<User> captor = ArgumentCaptor.forClass(User.class);

        userService.registerUser("Alice");

        verify(userRepository).save(captor.capture()); // capture le User passé

        User capturedUser = captor.getValue(); // récupère le User capturé
        assertEquals("Alice", capturedUser.getName());
    }
```

|                                                       | Utilise `ArgumentCaptor` ? |
| ----------------------------------------------------- | -------------------------- |
| Vérifier un appel avec une valeur simple              | ❌ Pas nécessaire           |
| Capturer l’objet transmis à une méthode               | ✅ Oui                      |
| Vérifier un objet complexe ou construit dynamiquement | ✅ Oui                      |
| Capturer plusieurs appels                             | ✅ Avec `.getAllValues()`   |

## Jayway - <a href="https://github.com/json-path/JsonPath" target="_blank">JsonPath</a>

* DSL java pratique pour lire les documents JSon et il est inclus dans la dépendance de test Spring-Boot.
* On peut l'utiliser pour faire des assertions sur le code JSon qui nous revient.

url: https://github.com/json-path/JsonPath
Mock return un objet JSon réel et on veut effectuer des tests sur le json remonté.

```java
// THEN - WHEN  
mockMvc.perform(get("/api/v1/beer/" + testBeer.getId())  
        .accept(MediaType.APPLICATION_JSON))  
        .andExpect(status().isOk())  
        .andExpect(content().contentType(MediaType.APPLICATION_JSON))  
        .andExpect(jsonPath("$.id", is(testBeer.getId().toString() )) )  
        .andExpect(jsonPath("$.beerName", is(testBeer.getBeerName())))
```

### import static
```java
import static org.hamcrest.core.Is.is;
```

## Jackson
### ObjectMapper
* Sert à sérialiser un objet en chaine de caractère et à déserialiser une chaine de caractère en objet 
* Spring Boot à dans son context un ObjectMapper préconfiguré. Cette configuration peut être overrider.

## UseCase - Test

### Create
```java
@Test  
void testCreateCustomer() throws Exception {  
    Customer customerToCreate = customerServiceImpl.getAll().get(0);  
    customerToCreate.setId(null);  
    customerToCreate.setVersion(null);  
  
    given(customerService.create(customerToCreate)).willReturn(customerServiceImpl.getAll().get(1));  
  
    mockMvc.perform(post("/api/v1/customer")  
            // ce que le client attend comme format de réponse
            // Accept: application/json
            .accept(MediaType.APPLICATION_JSON) 
            // ce que le client envoie comme format 
            .contentType(MediaType.APPLICATION_JSON)  
            // ce que le client envoie comme JSon
            .content(objectMapper.writeValueAsString(customerToCreate)))  
            .andExpect(status().isCreated()) 
            // test ce qe le serveur renvoie comme format de réponse
            .andExpect(content().contentType(MediaType.APPLICATION_JSON))  
            .andExpect(header().exists("Location"))  
    ;  
  
}
```