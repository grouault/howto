# spring-configuration

[retour](./../index.md)

## [bean - lifcecycle - init et destroy - InitaliseBean - DisposableBean - BeanPostProcessor - ApplicationContext](./annotation-bean-post-processor.md)

## [properties](./properties.md)

## [aspect](./aspect.md)

## [@Configuration](./../java-config/index.md)

## [@Profile](./profile.md)

## [@conditional](./conditional.md)

## Autres annotations Spring

### @EnableTransactionManagement
<pre>
* activation des transactions au niveau de la couche JPA
</pre>

### @EnableJpaRepositories
<pre>
@EnableJpaRepositories(basePackageClasses = LivreRepository.class)

* Permet de prendre en compte les repository JPA.
* fait office le ComponentScan

<i>public interface LivreRepository extends JpaRepository<Adherent, Integer> { ... }</i>
Ces repository ne sont pas annotés.


</pre>

### @RunWith
<pre>
@RunWith(SpringRunner.class)
@RunWith(SpringJUnit4ClassRunner.class)
</pre>

### @ContextConfiguration
<pre>
@ContextConfiguration(class={BiblioConfig.class, ...})
</pre>

### @EnableWebSecurity

### @EnableWebMvc

### @WebAppConfiguration