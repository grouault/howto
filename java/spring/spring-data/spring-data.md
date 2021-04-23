## Pagination
```
		// recuperation par pagination
		// on récupère la page 1 avec 2 éléments par page
		Page<Produit> produits = produitRepository.findAll(PageRequest.of(1, 2));
		System.out.println(produits.getSize());
		System.out.println(produits.getTotalElements());
		System.out.println(produits.getTotalPages());
		
		produits.getContent().forEach(p -> {
			System.out.println(p.toString());
		});
```

## Recherche

#### findByDesignation
* find : select * from Produit
* ByDesignation: where designation

```
public interface ProduitRepository extends JpaRepository<Produit, Long> {

	public List<Produit> findByDesignation();
	
}
```

#### findByDesignationContains
* contains : like %...%

```
	public interface ProduitRepository extends JpaRepository<Produit, Long> {

		public Page<Produit> findByDesignationContains(String mc, Pageable pageable);
		
	}
```

* Code appelant :

```
	// recuperation de tous Produits.
	Page<Produit> produits = produitRepository.findByDesignationContains("Imprimante", PageRequest.of(0, 2));
	produits.getContent().forEach(p -> {
		System.out.println(p.toString());
	});
```

#### Query

* Query hql

```
	/**
	 * recherche par designation et prix minimum
	 * 
	 * @param mc
	 * @param prix
	 * @param pageable
	 * @return
	 */
	@Query("select p from Produit p where p.designation like :x and p.prix>:y")
	public Page<Produit> chercherParDesignationEtPrixMinimum(
			@Param("x")String mc, @Param("y") double prix, Pageable pageable);
```