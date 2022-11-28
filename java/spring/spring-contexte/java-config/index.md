## @Configuration: java-config

[retour](./../index.md)

### principe

<pre>
- annnotation scanner par Spring
- Permet de fournir des informations de configurations dans une classe Java
- Permet notamment de créer des méthodes annotés par @Bean
</pre>

### Mise en place

<pre>
Cette annotation peut se mettre sur une ou plusieurs classes
Exemple : créer une cclasse  AppConfig

<i>
@Configuration
public class AppConfig(){

  @Bean
  public void createMonController(){ ... }

} 
</i>

On peut se passer des classes spécifique de configuration, 
en mettant l'annotation @Configuration sur la classe App.

La classe <b>App</b> est une classe exécutable.
La machine virtuelle va lancer la méthode static main.
La classe ne sera alors instancier qu'à l'exécution du code suivant :
ApplicationContext applicationContext = new AnnotationConfigApplicationContext(App.class);
L'objet sera placé dans le container léger de Spring
Le fait d'indiquer que la classe App est une classe de configuration va pousser
Spring à instancier cette classe.

<i>
@Configuration
@ComponentScan(basePackages = {
        "com.mycompany.dvdstore.controller",
        "com.mycompany.dvdstore.service",
        "com.mycompany.dvdstore.repository.impl.file"
})
@PropertySource("classpath:application.properties")
public class App 
{
    public static void main( String[] args )
    {
        ApplicationContext applicationContext = new AnnotationConfigApplicationContext(App.class);
        MovieController movieController = applicationContext.getBean(MovieController.class);
        movieController.addUsingConsole();
    }
</i>
</pre>

### @Bean

#### principe

<pre>
On peut ajouter aux classes annotés @Configuration des méthodes.
En annotant ces méthodes @Bean, elles ont vocation à fournir de objets supplémentaires
aux conteneurs légers.
Une méthode retourne un composant.
Exemple : un repository, un service, un controller ou tout autre composant util
au conteneur léger.
Il faut déclarer comme type de retour une interface
Exemple:

<i>
@Bean
public InvoiceService configureInvoiceService(){
  return new InvoiceServicePrefix();
}
</i>
</pre>

#### exemple

<pre>

@PropertySource
Derrière cette annotation se cache un new PropertySourcePlaceHolderConfigurer.
On pourrait remplacer cette annotation par le code suivant 

<i>
@Bean
public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
    PropertySourcesPlaceholderConfigurer configurer = new PropertySourcesPlaceholderConfigurer();
    configurer.setLocation(new ClassPathResource("application.properties"));
    return configurer;
}
</i>
</pre>

## lien

- [servlet 3.0](./servlet-3.0.md)
