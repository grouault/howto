# Introduction à la concurrence d'accès

[retour](./../readme.md)

## 1. Propriétés ACID des transactions

<pre>
- Atomicité (rollback) :
  Une transaction est opération atomique qui garantit que toutes les actions sont 
  entièrement exécutées ou qu'elle n'ont aucun effet

- Cohérence
  Pour une transaction validées, les données et ressources sont alors dans un état
  cohérent d'un point de vue métier.

- Isolation 
  * contexte : plusieurs transactions peuvent manipuler le même jeu de données
  * chaque transaction doit être isolée des autres afin d'éviter la corruption de données

- Durabilité (commit)
  * pour une transaction terminée, les résultats doivent survivre à toute panne du système

</pre>

## 2. Problèmes consécutifs à une concurrence sans controle

### 2.1 Défaut de serialisabilité

- les mises à jours perdues
- tuples fantômes

### 2.2 Défaut de recouvrabilité

Une exécution non-recouvrable introduit un conflit insolvable entre les commit effectué par une T et les rollback d'une autre.
On se trouve face à une exécution concurrente qui rend impossible le respect d'au moins une des deux propriétés transactionnelles requqites : la durabilité (Commit) ou l'atomicité (Rollback).

#### 2.2.1. Lecture sale

T2 lit une mise à jour de T1 alors que T1 n'a pas validé. La lecture sâle transmet un tuple modifié par T1 à T2.
T2 peut modifier et valider. Quid d'un rollback de T1?
T1 devient dépendante de T2 et ne peut plus faire de rollback car T2 a committé.

- R(T2): possible
- R(T1): impossible
- ==> exécution non recouvrable

##### Annulation en cascade

Idée : interdire T2 ayant fait une lecture sâle à partir de T1 de committer avant T1.
Si Rollback de T1, on rollback T2.

```
Pour eviter l'annulation en cascade, T2 ne doit lire qu'à partir des T validées
```

Exemple: r1[x] w1[y] r2[y] c1 w2[x] c2

- R(T1): possible mais engendre R(T2)
- R(T2) : possible, écriture après commit de T1
- ==> exécution recouvrable

En pratique:
Aucun SGBD ne fait d'annulation en cascade. La solution est donc d'interdire les dirty-read.

##### 2 solutions

- Soit T2 lit l'image avant de T1, qui par définition est une valeur validée
- Soit on met en attente les lectures sur des tuples en cours de modification

#### 2.2.2. Ecriture sale

- T1 modifie un tuple, T2 modifie le même tuple sans que T1 valide
- T1 fait un rollback, que se passe-t-il pour T2?
- Restauration de l'image avant de T1 et on pert l'écriture de T2
- ==> L'écriture sale efface un tuple modifié par une autre T par rétablissement de l'image avant.

#### Recouvrabilité strict

- on peut avoir des transactions sérialisables et non recouvrables et réciproquement
- le respect des propriétés ACID des T imposent au SGBD d'assurer la sérialisabilité des T et la recouvrabilité dite stricte, sans écriture ni lecture sale

#### 2.2.3 Synthèse

```
Principe:
* généralement, on cherche les écritures dans l'exécution.
* Ensuite, pour une écriture donnée, on vérifie s'il existe après d'autres lectures/écritures sur la même variable, réalisées par d'autres transactions.

  Anaylse :
* Une lecture peut indiquer un problème de recouvrablité (T2 lit de T1 des données non validées et commit)
* Une lecture peut indiquer un problème d'annulation en cascade (T2 lit des données non validées)
* Une écriture un problème d'exécution stricte (T2 ecrit le même tuple que T1 qui n'a pas validé)

Execution:
Recouvrable <== Eviter les annulation en cascade <== stricte
```

## 3. Les niveaux d'isolation
