### JUNIT

[home](index-junit.md)

### @Before, @After

<pre>
s'exécute avant et après chaque test définit sur la page
</pre>

### @BeforeClass, @AfterClass

<pre>
pour exécuter une opération coûteuse avant chaque test, il est 
préférable d'utiliser cette annotation.
exécuter une seule fois avant de d'éxécuter tous les tests.
</pre>

## Ordre des tests

<pre>
Utiliser l'annotation suivante
</pre>

```
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class TestVehiculeDAO {

    @Test
    public void a1_insertVehicule(){
        LOG.info("Test insert Vehicule");


    @Test
    public void a2_updateVehicule() {
        LOG.info("Test update Vehicule");

```
