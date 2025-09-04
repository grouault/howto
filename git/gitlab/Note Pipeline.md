### Type de pipelineTypes de pipeline possible

### 🔁 Types de pipelines dans GitLab

1. **Pipeline de branche (`branch pipeline`)**  
    S’exécute **automatiquement** à chaque commit poussé dans une branche (ex. : `feature/xyz`), indépendamment de toute MR.
    
2. **Pipeline de merge request (`merge request pipeline`)**  
    S’exécute **lorsqu'une MR est créée ou mise à jour** (nouveau commit, changement de base, etc.).  
    Cette pipeline est contextuelle à la MR : elle peut simuler ou tester ce que donnerait la **fusion** de la source dans la branche cible.
    
3. **Pipeline de la branche de destination (`target branch pipeline`)**  
    S’exécute **après la fusion**, c’est donc la pipeline "classique" de la branche principale (`main`, `master`, etc.) une fois le code intégré.

| Type de pipeline             | Quand est-elle créée ?                                          | Variable GitLab                                               |
| ---------------------------- | --------------------------------------------------------------- | ------------------------------------------------------------- |
| Pipeline de branche          | À chaque push dans une branche                                  | `$CI_PIPELINE_SOURCE == "push"`                               |
| Pipeline de MR (MR pipeline) | **Uniquement** si configurée avec `rules:` ou options du projet | `$CI_PIPELINE_SOURCE == "merge_request_event"`                |
| Pipeline de "merge result"   | Si activée manuellement dans les paramètres du projet           | `$CI_PIPELINE_SOURCE == "merge_request_event"` + merge result |

### Activation des pipelines MR

#### Principe

- ✔️ **Par défaut**, un `push` sur une branche (même avec une MR) déclenche **seulement une pipeline de branche** (`push`)
- ❗ **Tu vois parfois 2 pipelines** uniquement si **le `.gitlab-ci.yml` ou les paramètres projet** activent explicitement une **pipeline de MR**.
- ✔️ GitLab **affiche dans la MR la dernière pipeline de branche** associée, sauf s’il existe une pipeline `merge_request_event`, qui sera alors prioritaire

Une règle rentre en jeu par exemple sur un job, si on décide le l'exécuter que sur une pipeline de branche et plus sur la branche principale. Là on altère le comportement entre les deux branches en excluant un job de la pipeline de branche sur la branche principale. Ce job sera donc mis automatiquement par GitLab dans une MR pipeline qu' il va alors créé.

Dans le cas où une règle rentre en jeu, une pipeline MR est créée
* soit avec l’exclusion conditionnelle d’un job, **GitLab crée une pipeline dédiée à la MR** car les conditions d’exécution sont différentes.
* soit avec des règles spécifiques écrite dans gitlab-ci.yml
```yaml
rules:
  - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
```
➡️ Ce type de règle **force GitLab à créer une pipeline de type `merge_request_event`**, distincte de la pipeline de branche.

ou en activant une option du projet GitLab
➡️ Dans **Settings > CI/CD > Merge requests**  
Coche l’option :
- ✅ _Pipelines for merged results_
- ✅ _Merge request pipelines_
Cela permet à GitLab de **créer automatiquement** une pipeline spéciale au moment de la MR.

#### Contexte d'exécution de la pipeline

Une pipeline de MR a son propre contexte et ses propres règles à évaluer.

🔍 1. GitLab _peut changer le type de pipeline en fonction du contexte_
Mais en modifiant le comportement d’un job **en fonction de la branche**, GitLab **peut décider de déclencher une deuxième pipeline** — de type `merge_request_event` — **s’il pense qu’il y a une différence potentielle de comportement** dans le contexte de la MR.

> Même si les règles sont "les mêmes", GitLab **détecte que leur évaluation pourrait changer** entre une branche (`CI_COMMIT_BRANCH == feature/xyz`) 
> et une MR (`CI_MERGE_REQUEST_TARGET_BRANCH_NAME == main`, et `CI_COMMIT_BRANCH` reste `feature/xyz`).

---

🔄 2. Deux pipelines apparaissent car GitLab évalue deux _sources différentes_

|Pipeline|Variable `$CI_PIPELINE_SOURCE`|`$CI_COMMIT_BRANCH`|`$CI_MERGE_REQUEST_TARGET_BRANCH_NAME`|
|---|---|---|---|
|Pipeline de branche (push)|`push`|`feature/xyz`|(non défini)|
|Pipeline de MR|`merge_request_event`|`feature/xyz`|`main`|

Même si **le code du `.gitlab-ci.yml` est identique**, GitLab distingue les deux **contextes d’exécution**, ce qui entraîne l’exécution **de deux pipelines distincts**.

🧪 3. GitLab déclenche la pipeline de MR quand il _soupçonne_ un comportement différencié  
En ajoutant une règle comme `if: '$CI_COMMIT_BRANCH == "main"'`, tu donnes un **critère de variation de comportement selon la branche**, ce qui pousse GitLab à déclencher une pipeline supplémentaire dans le contexte MR.

Résumé

| Situation                                                                     | Pipeline déclenchée                       | Pourquoi ?                                                   |
| ----------------------------------------------------------------------------- | ----------------------------------------- | ------------------------------------------------------------ |
| Commit sans règle conditionnelle                                              | Pipeline de branche uniquement            | Aucun comportement conditionnel à tester                     |
| Commit avec règle qui change le comportement selon la branche (`main` ou pas) | Pipeline de branche **et** pipeline de MR | GitLab veut tester si la MR aurait un comportement différent |

#### Evaluation des règles (rules)

👉 Si un job n’a **pas de règle le rendant exécutable dans le contexte d’une MR**, **il est ignoré** dans la pipeline MR.
Dans une pipeline de MR :
- `$CI_PIPELINE_SOURCE == "merge_request_event"`
- `$CI_COMMIT_BRANCH` est ta branche source (ex : `feure/abc`)
- `$CI_MERGE_REQUEST_TARGET_BRANCH_NAME` est `main`

Mais **les règles comme** :
```yaml
- if: '$CI_COMMIT_BRANCH == "main"'
```
sont **évaluées par GitLab indépendamment dans chaque contexte**.

➡️ Si GitLab estime que la règle **n’est pas assez explicite pour inclure la MR**, **il ignore le job**.

🧪 À noter
GitLab a tendance à **ne pas exécuter un job dans une pipeline de MR** si :
- aucune `rule` ne matche clairement `merge_request_event`
- le job est exécuté uniquement dans les pipelines de type `push`

### inclure les jobs dans une pipeline de MR

* adapter chaque règle
```yaml
build:
  script: echo "Build"
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: never
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: always
    - when: always

test:
  script: echo "Test"
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: never
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: always
    - when: always

```
* règle générique
```yaml
rules:
  - if: '$CI_COMMIT_BRANCH == "main"'
    when: never
  - if: '$CI_MERGE_REQUEST_TARGET_BRANCH_NAME == "main"'
    when: always
  - when: always
```


### Pipeline de Branch vs Pipeline de MR

> ❗️**Même si les pipelines deviennent identiques en termes de contenu (jobs exécutés)** grâce à tes `rules` bien écrites, **GitLab continuera à créer deux pipelines distinctes** :
> - Une **pipeline de branche** (`push`)
> - Une **pipeline de merge request** (`merge_request_event`)  

**Pourquoi ?** Parce que les **sources de déclenchement sont différentes**, et GitLab traite ces pipelines comme **indépendantes**.

---
 🔍 Détail technique
🔸 Les deux pipelines sont créées pour des raisons différentes :

| Type de pipeline    | Déclenchée par ?                                          | Utilisée pour quoi ?                       |
| ------------------- | --------------------------------------------------------- | ------------------------------------------ |
| Pipeline de branche | Un `git push` sur une branche                             | Pour tester la branche indépendamment      |
| Pipeline de MR      | La création ou mise à jour d’une MR `merge_request_event` | Pour tester le résultat potentiel du merge |

➡️ Même si elles exécutent **exactement les mêmes jobs**, GitLab les considère **comme deux entités distinctes**, car :
- Elles ne sont **pas déclenchées par le même événement**
- Elles n'ont **pas la même utilité dans l'interface GitLab**

---
🧠 Pourquoi GitLab fait ça ?
1. **Sécurité et confiance dans les MRs** :
    - Une pipeline de branche peut réussir, mais une MR peut échouer une fois mergée (ex. : conflits, comportements spécifiques à `main`, etc.).
2. **Visibilité dans l'interface** :
    - La pipeline de MR est **liée explicitement à la MR**, avec des statuts (`passed`, `failed`, etc.) visibles dans l’onglet de la MR.
    - Elle permet des règles comme : _“ne pas permettre le merge si la pipeline MR échoue”_.

### Merge Request et Pipeline

> 🔹 **Quand tu crées une MR à partir d'une branche, GitLab ne crée pas automatiquement deux pipelines**.  
> Il crée **une seule pipeline par événement déclencheur**.

Donc :
🔹 Si tu **pousses du code sur ta branche (même si elle a une MR ouverte)** :
➡️ GitLab déclenche une pipeline de **type `push`** (pipeline de branche).  
Elle apparaît **dans la MR**, sauf si une MR pipeline est configurée en plus.
🔹 Si tu **actives manuellement ou via règles une pipeline de type `merge_request_event`** :
➡️ GitLab peut déclencher **une pipeline _en plus_**, propre au contexte MR.

📌 À retenir

| Action                                                                     | Ton `.gitlab-ci.yml`  | Pipeline créée | Source                |
| -------------------------------------------------------------------------- | --------------------- | -------------- | --------------------- |
| Push sur une branche, sans MR                                              | aucune règle spéciale | ✅              | `push`                |
| Push sur branche avec MR ouverte, sans règle spéciale                      | aucune règle spéciale | ✅              | `push`                |
| MR créée, sans règle spéciale                                              | aucune règle spéciale | ❌              | —                     |
| MR créée, avec `rules: if: '$CI_PIPELINE_SOURCE == "merge_request_event"'` | oui                   | ✅              | `merge_request_event` |
| MR mise à jour, avec `only: [merge_requests]`                              | oui                   | ✅              | `merge_request_event` |
| Merge vers `main`                                                          | Pipeline de branche   | ✅              | `push`                |

Quand tu fais un **`git push` sur ta branche qui a déjà une MR ouverte**, GitLab déclenche :

1. ✅ **Une pipeline de branche**    
    - Type : `push`
    - Déclenchée par l’événement `push`
    - C’est la pipeline "classique", toujours créée lors d’un `git push`
2. ✅ **Une pipeline de merge request (MR)**
    - Type : `merge_request_event`
    - **Déclenchée uniquement parce que** ton `.gitlab-ci.yml` contient un ou plusieurs jobs avec une règle **spécifique à ce contexte**, comme :
```yaml
rules:
  - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
    when: always
```
* GitLab déclenche cette pipeline **en plus**, car il détecte que des jobs veulent s'exécuter **dans le contexte de la MR**.
* 
### Création d'une pipeline MR

🟨 ** une pipeline de type `merge_request_event` ne peut _jamais_ exister si aucune Merge Request (MR) n’a été créée.**

Même en ajoutant ce type de règles:
``` yaml
rules:
  - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
    when: always
```

➡️ **Aucune pipeline de MR ne sera déclenchée** tant qu’il n’existe **pas au moins une Merge Request ouverte** depuis la branche en question.

🧠 Pourquoi ?
Parce que GitLab ne **peut pas déclencher une pipeline `merge_request_event` sans MR réelle**, pour une raison très simple :
> Ce type de pipeline a besoin du **contexte de la MR** (branche cible, auteur, diff, etc.).

🔍 Exemple concret
Tu pousses une branche `feature/abc` **sans créer de MR** :

```yaml
job:
  script: echo "run"
  rules:
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: always
```

➡️ Résultat :
- ❌ **Le job ne tourne pas**
- ❌ **Aucune pipeline `merge_request_event` n’est déclenchée**
- ❌ Tu n’as même **pas de pipeline du tout** si **aucun autre `rule` ne s’applique** (et pas de `when: always` hors MR)

Il faudrait ajouter la règle suivante pour faire tourner la pipeline de branche
```yaml
job:
  script: echo "run"
  rules:
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: always
    - if: '$CI_COMMIT_BRANCH != "main"'
      when: always
```

➡️ Dans ce cas :
- Si tu **pushes sur une branche sans MR** → pipeline `push` est déclenchée, le job tourne
- Si tu **crées une MR** → pipeline `merge_request_event` est déclenchée aussi, le job tourne aussi

### Workflow

#### Principe
* cela permet de définir quand est-ce que les piplelines sont créés.

####  Eviter la double pipeline
🧠 Astuce finale
Si tu veux **éviter la double pipeline**, tu peux forcer une distinction avec `workflow.rules` :
```yaml
workflow:
  rules:
    - if: '$CI_COMMIT_BRANCH'
      when: always
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: never
```
Ou inversement, selon ce que tu veux.

👉 Ici, on active
* les MRs pipelines pour les travaux/jobs dont on a besoin ; c'est à dire tous.
	➡️ la règle se lit de la manière suivante : si nous voulons créer une nouvelle MR, alors nous voulons créer une MR pipeline. Cela active tous les jobs sur la pipeline sauf s'ils sont exclus par d'autres règles.
* juste la pipeline de branch Main (ou de la banche principale) et on désactive les autres branches. Chaque fois que GitLab essaie d'ajouter un pipeline de branche, le process est stoppé avec cette règle.
	➡️ la règle se lit de la manière suivante : si la banche sur laquelle on commit est la branche par défaut alors une pipeline de branche sera crée sur cette branche.

```yaml
workflow:
  rules:
    - if: '$CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH'
      when: always
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      when: always
```

🧪 Note: Il ne faut pas utiliser $'CI_COMMIT_REF_NAME == $CI_DEFAULT_BRANCH' car cette variable reprend la pipeline en cours d'exécution ; alors même que cette pipeline n'est pas créé puisque c'est ce que l'on configure.

#### vs Default