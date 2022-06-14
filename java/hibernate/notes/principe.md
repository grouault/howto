[home](../index.md)

### 3 règles d'or

- toujours connaître l'état de la session/contexte de persistence
  - savoir si on est ou pas dans une session
- savoir si on est ou pas dans une transaction
- toujours se soucier du sql généré par hibernate

### session hibernate

- une session c'est quoi
- on peut le voir comme une map<classe+ID, entité>
- une entité géré par hibernate est dans la session/ dans la map
-

### les états JPAs

- orm : intermédiaire entre applis et la base de données
- contexte de persistence : ensemble des entités géréés par hibernate

#### transient

- entité non connu du contexte de persistence
- concerne les nouveaux objets (new)
- méthode :
  - persist(e): pour mettre l'entité dans le contexte de persistence

#### managed

- entité géré par hibernate
  - flush(): hibernate enverra les modifs vers la base de données
- méthode pour mettre l'entité dans l'état "managed"
  - persist(e)
  - find(e)
  - getReference()
  - getResultList()

#### removed

- remove(e): supprimé une entité qui est dans l'état managed
  - sur une entité connu du contexte de persistence
  - l'entité passe dans l'état Removed et hibernate envoie les suppressions au SGBD
    via la méthode flush()
- persist(e): on peut l'utiliser pour remettre l'entité dans la session dans l'état managed

#### detached

- une entité peut être retirée du contexte de persistence
  et dire à hibernate de ne plus gérer l'entité
- méthode pour retirer l'entité de la session :
  - detach(e)
  - clear()
  - close()
- merge(e) :
  - réattacher l'entité à la session
    - récupère l'entité en base
    - fait un update s'il y a un delta
  - si l'entité est nouvelle, cela revient à faire un persist()

### Mauvaise pratiques

- Il ne faut jamais déterminé l'id de manière programmatique. C'est hibernate qui s'en occupe.
- On peut le faire pour tricher, pour simuler un merge.

## Définition

### EntityManager

- permet de déclencher des actions sur les entités
- ces actions permettent entre autre de changer l'état d'une entité

#### getReference() - proxy

### Session

### Transaction

#### @Transactional

- Spring va ouvrir une session avec la Transaction

### proxy / lazy loading

- un proxy est une référence vers une entité de la base qui n'est pas complètement chargée,
  mais chargeable à la demande si la session hibernate est encore ouverte.
- le lazy-loading ne peut donc se faire que pour des entités dans un état 'MANAGED'

### Flush

- force l'entity manager a envoyé ses modifications à la base de données
- en général, c'est une mauvaise pratique
- hibernate flush automatiquement à la fermeture de la session

### Dirty checking

- Fonctionnalité du contexte de persistence qui concerne les entités managed
- permet de faire la mise à jour des données et donc
  de répondre à la question suivante : comment fait-on un update avec hibernate ?
- Toute modification faite sur l'entité à l'état MANAGED sera enregistrée dans la session et
  propagée jusque dans la base de données.
- Quel est le principe :
  Hibernate maintient en plus de la session, un snaphot qui est une photographie des entités au
  chargement. Au flush, hibernate fait une comparaison entre les entités de la session et du
  snaphot. Toute entitié modifié sera mis à jour en base.
  Hibernate met alors à jour toute l'entité même si un seul champ a été modifié.

### Cache

#### cache de premier niveau

- si on demande des objets à Hibernate, hibernate va d'abord les chercher dans son cache
- utilité du cache de session:
  1- réduire le nombre de requête vers la BDD
  2- stocker les modifs et les envoyer en BDD au bon moment
- hibernate à la charge de renvoyer l'état à jour de l'entité
  - Sale = Dirty = modifié
  - C'est à hibernate de savoir qu'un objet est sale

### Hibernate et Event

- Hibernate fonctionne beaucoup par Event
- Utile pour trouver/surcharger certaines classes
