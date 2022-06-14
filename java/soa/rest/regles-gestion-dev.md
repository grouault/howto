[home](../index-soa.md)

## 404 : get - delete - put

- Quand on on ne peut pas récupérer la données à envoyer ou à modifier ou à supprimer
  il faut renvoyer un NOT-FOUND ou 404
  Exemple:
  ```
   @GetMapping("/{id}")
   public ResponseEntity<Movie> get(@PathVariable Long id) {
       Movie movie = movieService.getMovie(id);
       if (movie == null) {
           return ResponseEntity.notFound().build();
       } else {
           return ResponseEntity.ok(movie);
       }
   }
  ```
