
## Account
```
https://gitlab.com/grouault-projects/learn-gitlab-app
grouault/gildasrouault@gamil.com/G****b...4
```

# Pipeline

### Définition
Une pipeline est un enchainement de une ou plusieurs étapes (step) qui :
* sont reliées entre elles
* doivent être effectuées dans un certain ordre
* ont pour objectif de produire un résultat final qui peut être la production du livrable de l'application par exemple.
La a sortie d'une étape (output) est l'entrée de l'étape suivante.
Les étapes peuvent aussi s'exécuter en parallèle.
Le produit final généré par la pipeline doit être en état de marche.

## Architecture GitLab
GitLab est structuré de la manière suivante :

* GitLab Server : une partie server responsable :
	* de la partie repository pour le stockage des sources du projet et des branches
	* de l'exécution du pipeline et de la coordination des jobs de la pipeline
* GitLab Runner :  les runners sont les agents qui permettent d'exécuter les jobs.

<img src="./img/excalidraw/gitlab/archi-gitlab.png" />

🟥 Attention: ce schéma est trompeur car on a pas de fichier gitlab-ci.yaml par branche. Ce fichier est unique. Ce sont les jobs à l'intérieur de ce fichier qui seront à déclencher suivant la branche de commit.

### Gitlab Server
* la pipeline est trigger à chaque fois qu'une modification intervient sur le repository
* Le server Gitlab trouvera un runner (agent) pour exécuter le travail.
* l'agent doit être configuré pour utiliser Docker comme exécuteur
	```log
	Preparing the "docker+machine" executor
	```

<img src="./img/architecture.png" />

* le runner reçoit des instructions du server qui est appelé le coordinateur
	* il démarre le container
	* il clone le repository dans un workspace temporaire sur le container
	* les commandes du bloc scripts sont exécutées
	* si tout est ok, le runner prend le répertoire de construction et l'envoie en tant qu'artifact au serveur GitLab pour une utilisation ultérieure (l'endroit ou est déposé par Gitlab n'a pas d'importance - géré par Gitlab en interne)
	* une fois toutes les opérations effectuées le container est terminé et Gitlab continue avec le reste du pipeline s'il y a d'autre jobs ou stages à exécuter.

<img src="./img/architecture-2.png" />

🟥 IMPORTANT
* il n'est pas possible de laisser un job tournée pour qu'il soit accessible par un autre job ou pipeline
*  pour chaque job, un container docker est démarré et terminé, sur des machines pouvant être différente
### Gitlab Runner

### Job
Un Job est une unité d'exécution. Il s'exécute dans un processus dédié.
Un job doit être associée à une tâche claire et précise :
* cela facilite la maintenance
 * permet d'identifier au mieux les problèmes

Les jobs qui sont dans un même stage se lancent en parallèle.

Si pas défini, tous les jobs se lancent en parallèle et se retrouve dans le stage Test.
Par défaut, un job s'exécute dans le stage Test.
Par défaut GitLab définit les stage suivants:

🧱 Définition des `stages` : ordre global
```yaml
stages:
  - .pre
  - build
  - test
  - deploy
  - .post
```

> Cela signifie :
- tous les jobs du stage `build` sont exécutés en premier (en parallèle si possible),
- puis tous les jobs du stage `test`,
- puis ceux du stage `deploy`.

⚙️ 2. Affectation des jobs à un stage
Chaque job est affecté à un stage via la clé `stage:` :

```yaml
build_app:
  stage: build
  script: echo "Building..."

run_tests:
  stage: test
  script: echo "Running tests..."

deploy_app:
  stage: deploy
  script: echo "Deploying..."
```

> Si aucun `stage` n’est précisé dans un job, **il sera automatiquement affecté au premier stage** de la liste définie dans `stages:`

🔁  Ajout de nouveaux stages
Lorsque tu ajoutes un stage, tu dois **l'insérer manuellement dans la liste `stages:`** à l'endroit souhaité.  
GitLab **n’impose aucun tri automatique**. C’est **l’ordre dans `stages:` qui est la vérité absolue**.

Exemple :

```yaml
stages:
  - build
  - test
  - security_scan  # Ajouté ici, donc exécuté après test
  - deploy
```

🧪 Jobs dans un même stage

Les jobs dans un même stage :
- s'exécutent **en parallèle**, si des runners sont disponibles,
- la pipeline ne passe au stage suivant **que si tous les jobs du stage actuel réussissent** (sauf si des règles d’exception sont définies, comme `allow_failure: true`).

<img src="./img/ci/pipeline-ex.png" />

___
### build project - npm ci
* permet d'installer les dépendances du projet -  permet de faire un npm install
* utiliser le fichier package-lock.json
* plus rapide car il conserve certaines fonctionnalités de calcul (comme l'arbre de dépenance)

## Principe
Quand on fait une pipeline, il faut savoir ce que l'on veut faire. On ne peut pas automatiser quelques choses si on ne connait pas toutes les étapes ; construire une usine de fabrication de voiture n'a pas de sens si on ne connait pas toutes les étapes d'assemblage.
Pour un projet informatique les étapes sont souvent les mêmes:
* installés les dépendances
* construire / compiler le projet
* tester le projet à partir du livrable construit
Ces étapes doivent être réalisé localement au préalable.
Ainsi pour faire tourner un projet react, on a besoin successivement de lancer les commandes suivantes ; ce sont ces commandes qu'il conviendra d'automatiser.

```cmd
> npm install
> npm run build
> npm install -g serve
> serve -s build/
```

## YAML
### exemple-1
```yml
stages:
  - build

build_website:
  image: node:22-alpine
  stage: build
  script:
    - node --version
    - npm --version
    - ls -la
    - npm ci ## equivalent à npm install
    - npm run build
    - ls -la
```
exemple-2
```yaml
stages:
  - build
  - test

build_car:
  image: alpine
  stage: build
  script:
    - echo "Building the car"
    - mkdir build
    - cd build
    - touch car.txt
    - echo "chassis" > car.txt
    - echo "engine" >> car.txt
    - echo "wheels" >> car.txt
    - cat car.txt
  artifacts:
    paths:
      - build/

test_car:
  image: alpine
  stage: test
  script:
    - test -f build/car.txt
    - grep "chassis" build/car.txt
```

## artifacts
* permet de partager des datas entre les différents jobs de la pipeline
* sert à la transmission d'information entre les jobs
* permet de sauvegarder les éléments définis à l'issu de l'exécution de la pipeline

### path
permet 
```yml
job:
  artifacts:
    paths:
      - binaries/
      - .config
```
Créer un artifact with `.config` et tous les fichiers du répertoire `binaries`.

### reports
permet de générer des artifacts spécifique comme JUnit par exemple
```yaml
artifacts:
  when: always // publié même si le job plante
  reports:
    junit: reports/junit.xml
```

### expire_in
Par défaut, les artefacts sont toujours conservés pour le pipeline réussi le plus récent sur chaque référence. Toute configuration expire_in ne s’applique pas aux artefacts les plus récents.

Lorsqu’un nouveau pipeline sur la même référence se termine avec succès, les artefacts du pipeline précédent sont supprimés selon la configuration expire_in. Les artefacts du nouveau pipeline sont conservés automatiquement.

Les artefacts d’un pipeline ne sont supprimés selon la configuration expire_in que si un nouveau pipeline fonctionne pour le même ref et :
* Réussit.
* Arrête de fonctionner s'il est bloqué par un job manuel.

### ⏱ Formats valides pour `expire_in`
Tu peux utiliser des durées humaines lisibles, par exemple :
- `30 mins`
- `2 hrs`
- `1 day`
- `3 days`
- `1 week`
- `2 months`
- `1 year`
    
> GitLab comprend aussi bien `minutes`, `hours`, `days`, `weeks`, `months`, `years`.

❗Important
- Tu peux désactiver l’expiration en définissant `expire_in: never` (attention, cela peut ne pas être supporté selon la version de GitLab ou la configuration admin).
- ❌ Tu **ne peux pas changer** la durée d’expiration par défaut des artifacts (30 jours) globalement pour ton projet ou ton groupe. Tu dois donc le faire **manuellement job par job** si tu veux des durées personnalisées.
---
📌 Exemple complet

```yaml
test_job:
  stage: test
  script:
    - pytest tests/
  artifacts:
    paths:
      - reports/
    expire_in: 2 days # <--- tu contrôles ici la durée pour ce job
```

Ici, les rapports de tests seront accessibles pendant **2 jours** après la fin du job `test_job`.

🧩 Astuce (facultative) :

Tu peux factoriser ça si plusieurs jobs utilisent la même logique, par exemple :

```yaml
.default_artifacts:
  artifacts:
    expire_in: 3 days

build_job:
  extends: .default_artifacts
  script:
    - make build
    - make package
  artifacts:
    paths:
      - dist/

test_job:
  extends: .default_artifacts
  script:
    - run-tests
  artifacts:
    paths:
      - test-reports/
```

Ainsi, tu évites la répétition de `expire_in`. 48
## Test

### Run Test
Le but est ici de lancer les test unitaires via la commande suivante :
```cmd
> npm test
```

```yaml
test_unit:
  image: node:22-alpine
  stage: test
  script:
    - npm ci
    - npm test
  artifact:
    when: always
    reports:
      junit: reports/junit.xml
```

### Report
#### CLI Report
Test que l'on voit dans les journaux d'exécution du pipeline

#### Publishing Junit Report
C'est un fichier généré dans le cadre du projet JUnit de Java souvent au format xml. Il fournit des infos sur les résultats de test.
Beaucoup d'outils de tests génère un ficher de rapport au format xml de JUnit qui devient presque de fait un standard.
Le fichier est généré à l'issu de l'exécution des tests et est présent dans le répertoire qui a été configuré 
```
vite.config.js
```
Il fournit au format xml des données tels que le :
* statut (echec/succes)
* les temps d'exécution
* message d'erreur
* statistiques récapitulatives
Ce rapport peut être ensuite analyser et mise en forme par des systèmes tiers tel que Gitlab.
```js 
    // vite.config.js
    reporters: ['verbose', 'junit', 'html'],
    outputFile: {
      junit: './reports/junit.xml',
      html: './reports/html/index.html'
    }
```
Pour construire le fichier, il faut dans la pipeline le produire et le publier dans GitLab ; il doit alors être conçu comme un artifact. Le code suivant suffit à Gitlab pour savoir comment interagir avec ce rapport (le chemin spécifié est celui qui définit où est présent le fichier xml généré à l'issu des tests)
```yaml
artifacts:
  when: always // publié même si le job plante
  reports:
    junit: reports/junit.xml
```

## Règle de structure Pipeline

* faire en sorte que les jobs rapident et qui sont susceptibles de déclencher des erreurs rapidement comme le linter soient placer au début de la pipeline
* séquentialité des jobs en fonction de leur dépendance ou pas
* paralléliser les jobs qui ont une durée similaires et qui sont indépenants

# Continuous Integration
consiste à intégrer les changements

## Repository et Branche Main
GIT est utilisé comme dépôt (repository) central sur GitLab et pour gérer les versions (version du logiciel).
Le repository permet de créer différentes branches. Chaque branche permettra d'isoler/de travail indépendamment du contenu de la branche initiale.
La version du logiciel est souvent créé à partir de la branche principale : main.
Cette branche doit toujours être opérationnelle pour que l'application ne soit jamais arrêtée.
C'est pourquoi les travaux non testés de doivent jamais être poussés sur la branche principale.

<img src="./img/ci/branch-main-alone.png" />

## Feature Branch
Il convient alors d'automatiser l'intégration des nouveautés avec un mécanisme qui garantit l'intégrité de l'application donc de la branche main.
L'automatisation permettra alors que toute nouvelle modification sera testée avant d'être ajoutée à la banche principale. 
Il faut pour cela travailler avec des branches fonctionnelles (feature branch) qui seront intégrées dans la branche principale. Chaque développeur peut ainsi travailler indépendamment.
Une pipeline est créée pour toute nouvelle branche et simule l'exécution de la branche principale.

## Merge Request
Dans le cadre du travail avec les branches, une demande de fusion (MR) est une demande faite aux autres développeurs de revoir le code avant qu'il ne soit fusionné.
C'est une demande d'ajout des modificaitons proposées à la branche principale.

<img src="./img/ci/merge-request.png" />

### Configuration
Les MR peuvent être configurées différemment sur GitLab suivant le projet.
#### Merge Method: Fast-forward merge
 * cette méthode empêche les commits de fusion
 *  permet de conserver un historique plus propre
### Squash Commit
* permet de combiner plusieurs commits en un seul (à mettre sur la valeur encourage)
### Merge Checks
Dans cette configuration, il convient de s'assurer que la pipeline est en succès avant toute fusion.
La configuration permet de décider du comportement donné au thread (fil de discussion)
### Target project
* permet de définir le projet à partir duquel la MR sera créé (choix entre le projet courant et l'upstream project s'il existe dans le cas de projet forké).

## Repository
Le repository est l'endroit où sont stockées les sources de l'application. 

### Protected Branch
* permet de protéger la branche principale des commits directs et de forcer les développeurs à créer des demandes de MR. Pour cela mettre la configuration suivante:
```
allowed to push and merge => No One
```
### 🔒 Quel rôle choisir par défaut ?

Par défaut, il est **recommandé de choisir le rôle "Maintainer"** pour exécuter les pipelines
##### 📌 Pourquoi choisir "Maintainer" ?

- Les Maintainers ont déjà des droits élevés sur le projet, y compris la gestion des pipelines, des runners, des secrets, etc.
- Cela empêche les développeurs ou contributeurs occasionnels de déclencher accidentellement ou volontairement des pipelines qui exposeraient des secrets.
- Cela permet de restreindre l’utilisation des variables sensibles tout en gardant une bonne flexibilité pour les opérations CI/CD.
    
🧩 Détail des rôles (par ordre croissant de permissions) :
1. **Guest**
2. **Reporter**
3. **Developer**
4. **Maintainer**
5. **Owner** (uniquement pour les groupes, pas dans les projets)

📚 Exemple GitLab :

Dans l’interface GitLab :  
`Settings` > `CI / CD` > `Variables` > `[Edit Variable]`  
→ **"Environment scope"**  
→ **"Protected"**  
→ **"Mask variable"**  
→ **"Minimum role required to use the variable in pipelines"**
Sélectionner **"Maintainer"** ici permet d'assurer une sécurité raisonnable par défaut.


---
# Continuous Deployment

## variables d'environnement

### Définition
* une variable d'environnement est un concept du système d'exploitation
* dans GitLab elles sont utilisées pour stocker et gérer les valeurs de configuration qui peuvent varier d'un environnement à un autre.
* il faut supprimer au maximum tout paramètre de configuration du code et des commandes et utiliser à la place des variables d'environnement car elles offrent une plus grande flexibilité.
* Pour configurer  les outils clients en général (commet Netlify CLI), il faut utiliser des variables d'environnement. C'est un concept clé du DevOps.
* cela permet de la configuration sans hardcoder les valeurs dans le script.

### GitLab
Il est donc important de définir les variables d'environnement au niveau de GitLab.
On peut définir les variables :
* à partir du fichier de configuration
* via le client WEB

#### stocker dans le fichier de configuration
Les variables peuvent être définies 
* au sein du pipeline :  configuration de variable de premier niveau. Les variables sont disponibles pour l'ensemble du pipeline.
* au sein d'un job : disponible que pour le job. Il est impossible d'accéder à ces variables nulle part ailleurs (Cela permet de redéfinir les variables de même nom définit au niveau supérieur).

```yaml
netlify:
  image: node:22-alpine
  stage: .pre
  variables:
    NETLIFY_SITE_ID: 'b47ed375-4921-45ce-bd67-8e1caadf0408'
  script:
    - npm install -g netlify-cli@20.1.1
    - netlify --version
```

####  stocker dans GitLab (Variables)
Section CI/CD dans les settings du projet GitLab
* possibilité de définir au niveau Group ; plusieurs projets peuvent hériter de ces variables
* sinon les définir au niveau de la partie CI/CD variables
Les propriétés sont les suivantes :
* Visible: pour être accessible dans les logs des jobs
* Masked: pas exposé dans les logs mais peut être visible en tant que Variable dans la configuration CI/CD de GitLab
* Masked and Hidden : personne ne peut la voir, ni la modifier après avoir été stocké même dans la configuration CI/CD.
Flags : (elles sont à décocher)
* Protect variables: uniquement accessible sur les branches protégées.

💡 **Bonnes pratiques** :
- Pour les variables très sensibles : utilisez aussi l’option "Protected" (utilisable uniquement dans des branches ou tags protégés).
- Ne jamais exposer de secrets dans les jobs exécutés par des utilisateurs non fiables.

----
## Smoke Test
C'est un test minimal qui vérifie que le déploiement s'est bien exécuté. Il s'agit ici d'avoir un mécanisme qui confirme le bon déploiement et pas seulement celui d'ouvrir la page web et de vérifier que tout fonctionne. 

📚 Exemple: faire un curl du site déployé et un grep d'une chaine de caractère dans la page ciblée.

---
## <a href="https://docs.gitlab.com/ci/yaml/#rules" target="_blank">Rules</a>

- Le bloc `rules:` sert à **déterminer si un job s’exécute** et **quand** (`when:`)

🟥 DANGER 
- `rules:` ne sert pas à configurer les paramètres comme `artifacts`, `cache`, etc.    
- `rules:` **n’accepte pas de sous-clé `artifacts`** dans ce contexte.
- GitLab parsera ce YAML sans erreur YAML, mais **ignorera ou rejettera** silencieusement les blocs incorrects (comme `artifacts:` dans `rules:`).
```yaml
job_with_artifacts:
  script:
    - make build
  artifacts:
    paths:
      - build/
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      artifacts:
        expire_in: 6 months
    - when: on_success
      artifacts:
        expire_in: 7 days
```

✅ La bonne manière de faire

GitLab a introduit **`artifacts:rules:`** depuis la version **13.10**, pour gérer dynamiquement `expire_in`.

Voici la **version correcte** :
```yaml
job_with_artifacts:
  script:
    - make build
  artifacts:
    paths:
      - build/
    rules:
      - if: '$CI_COMMIT_BRANCH == "main"'
        expire_in: 6 months
      - when: on_success
        expire_in: 7 days
```

🟢 Ici :
- `rules:` est **dans le bloc `artifacts:`**.
- C’est donc **`artifacts.rules:`**, et c’est cette syntaxe qui permet de changer dynamiquement la durée d’expiration.
### Variable d'environnement
Les rules se basent sur les variables d'environnement. Celles-ci sont disponibles et fournies par GitLab. Elles sont disponibles pendant l'exécution de la pipeline
pour les voir, mettre dans la partie script.

```yaml
Principales:
CI_COMMIT_REF_NAME: 
	- nom de la branche pour laquelle la pipeline est exécutée.
	- branche courante
CI_DEFAULT_BRANCH: nom de la banche par défaut (branche prinicpale)
CI_COMMIT_BRANCH: branche sur laquelle on a fait un commit
CI_PIPELINE_SOURCE: 
	- est essentiel pour détecter le contexte dans lequel GitLab exécute la pipeline
```

### CI_PIPELINE_SOURCE
| Valeur de `CI_PIPELINE_SOURCE` | Déclencheur de la pipeline                               | 💼 Contexte typique                             | 📘 Cas d’usage typique                                                                       |
| ------------------------------ | -------------------------------------------------------- | ----------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `push`                         | Commit / push sur une branche ou un tag                  | `feature/foo`, `main`, `develop`, etc.          | ✅ Tests unitaires, lint, build continu❌ Pas de déploiement ou de validations lourdes         |
| `merge_request_event`          | Création ou mise à jour d'une Merge Request              | MR de `feature/foo` vers `develop` ou `main`    | ✅ Tests de validation avant merge (lint, tests)✅ Outils type SonarQube, SAST, security scans |
| `web`                          | Lancement manuel via l'UI GitLab (bouton "Run pipeline") | Click sur “Run pipeline”                        | ✅ Rebuild, préprod, démo, pipelines facultatives🔒 Exécution contrôlée manuellement          |
| `schedule`                     | Déclenchement planifié (via cron dans GitLab)            | Planification journalière, hebdo, etc.          | ✅ Tests de non-régression✅ Tâches de nettoyage✅ Vérifications périodiques                    |
| `api`                          | Appel à l’API GitLab (POST `/pipeline`)                  | Déclenchement par un outil externe              | ✅ Intégration avec Jenkins, GitHub Actions, etc.✅ Lancer une CI depuis un outil personnalisé |
| `pipeline` / `parent_pipeline` | Déclenchement par une pipeline parente (via `trigger`)   | CI multi-projets, monorepo, découpage par blocs | ✅ Pipelines enfants modulaires✅ Distribution des responsabilités CI/CD                       |
| `external`                     | Webhook ou service externe connecté                      | GitHub, Bitbucket, autres SCM                   | ✅ Synchronisation de dépôt✅ Exécution de GitLab CI depuis GitHub                             |
| `chat`                         | Déclenchement via ChatOps (Slack, Teams, etc.)           | Utilisation d’une commande chat                 | ✅ Déploiement rapide✅ Lancer un test ou job de support directement via Slack                 |
| `webide`                       | Commit depuis l’éditeur WebIDE intégré à GitLab          | Développement dans GitLab WebIDE                | ✅ Peut être exclu si la CI est lourde ou coûteuse✅ Jobs plus légers et rapides               |
### Toutes les variables
```yaml
script:
  env
$ env
FF_USE_WINDOWS_LEGACY_PROCESS_STRATEGY=false
FF_SCRIPT_SECTIONS=false
FF_POSIXLY_CORRECT_ESCAPES=false
CI_SERVER_VERSION_PATCH=0
CI_SERVER_REVISION=a236c6e0eaa
CI_COMMIT_SHORT_SHA=1b2a21bf
GITLAB_USER_LOGIN=gildasrouault
CI_DEPENDENCY_PROXY_PASSWORD=[MASKED]
CI_DEPENDENCY_PROXY_SERVER=gitlab.com:443
FF_USE_DUMB_INIT_WITH_KUBERNETES_EXECUTOR=false
FF_USE_LEGACY_KUBERNETES_EXECUTION_STRATEGY=false
FF_LOG_IMAGES_CONFIGURED_FOR_JOB=false
FF_USE_LEGACY_S3_CACHE_ADAPTER=false
CI=true
CI_SERVER_PROTOCOL=https
CI_PROJECT_NAME=learn-gitlab-app
CI_RUNNER_REVISION=5c23fd8e
NODE_VERSION=22.15.1
HOSTNAME=runner-j1aldqxs-project-69510730-concurrent-0
CI_JOB_STAGE=deploy
CI_PROJECT_DESCRIPTION=
CI_COMMIT_DESCRIPTION=
YARN_VERSION=1.22.22
CI_DEPENDENCY_PROXY_USER=gitlab-ci-token
CI_SERVER_VERSION=18.1.0-pre
SHLVL=3
FF_DISABLE_POWERSHELL_STDIN=false
FF_CLEAN_UP_FAILED_CACHE_EXTRACT=false
FF_DISABLE_AUTOMATIC_TOKEN_ROTATION=false
CI_PROJECT_ROOT_NAMESPACE=grouault-projects
HOME=/root
OLDPWD=/
FF_NETWORK_PER_BUILD=false
CI_JOB_ID=10096934480
CI_SERVER_HOST=gitlab.com
CI_COMMIT_REF_NAME=feat/smoke-test
FF_RESOLVE_FULL_TLS_CHAIN=false
CI_PIPELINE_SOURCE=push
CI_RUNNER_VERSION=17.10.0~pre.41.g5c23fd8e
FF_SKIP_NOOP_BUILD_STAGES=true
FF_USE_FASTZIP=false
FF_USE_WINDOWS_JOB_OBJECT=false
CI_BUILDS_DIR=/builds
CI_SERVER_VERSION_MAJOR=18
CI_DEFAULT_BRANCH=main
NETLIFY_SITE_ID=dc358e9e-52d0-4987-85ba-d1ded89fb9f0
CI_REGISTRY_PASSWORD=[MASKED]
CI_SERVER_URL=https://gitlab.com
CI_TEMPLATE_REGISTRY_HOST=registry.gitlab.com
CI_COMMIT_REF_PROTECTED=false
GITLAB_FEATURES=ldap_group_sync,multiple_ldap_servers,seat_link,seat_usage_quotas,pipelines_usage_quotas,transfer_usage_quotas,product_analytics_usage_quotas,zoekt_code_search,repository_size_limit,elastic_search,admin_audit_log,auditor_user,custom_file_templates,custom_project_templates,db_load_balancing,default_branch_protection_restriction_in_groups,extended_audit_events,external_authorization_service_api_management,geo,instance_level_scim,ldap_group_sync_filter,object_storage,pages_size_limit,project_aliases,disable_private_profiles,password_complexity,amazon_q,enterprise_templates,git_abuse_rate_limit,integrations_allow_list,required_ci_templates,runner_maintenance_note,runner_performance_insights,runner_upgrade_management,observability_alerts
CI_PROJECT_ID=69510730
CI_REGISTRY_IMAGE=registry.gitlab.com/grouault-projects/learn-gitlab-app
FF_USE_LEGACY_GCS_CACHE_ADAPTER=false
GITLAB_CI=true
CI_COMMIT_SHA=1b2a21bf0fea0ff520013623bd831b96a159c586
FF_RETRIEVE_POD_WARNING_EVENTS=true
CI_CONCURRENT_ID=71
FF_DISABLE_UMASK_FOR_DOCKER_EXECUTOR=false
FF_USE_DOCKER_AUTOSCALER_DIAL_STDIO=true
CI_REGISTRY_USER=gitlab-ci-token
CI_SERVER_PORT=443
CI_PROJECT_DIR=/builds/grouault-projects/learn-gitlab-app
CI_PROJECT_PATH=grouault-projects/learn-gitlab-app
FF_ENABLE_JOB_CLEANUP=false
FF_WAIT_FOR_POD_TO_BE_REACHABLE=false
DOCKER_DRIVER=overlay2
CI_PROJECT_NAMESPACE=grouault-projects
CI_COMMIT_TIMESTAMP=2025-05-20T20:30:59+00:00
NETLIFY_AUTH_TOKEN=[MASKED]
FF_USE_DIRECT_DOWNLOAD=true
FF_USE_DYNAMIC_TRACE_FORCE_SEND_INTERVAL=false
CI_JOB_TOKEN=[MASKED]
CI_NODE_TOTAL=1
CI_SERVER_NAME=GitLab
CI_PROJECT_NAMESPACE_ID=106818434
CI_PIPELINE_CREATED_AT=2025-05-20T20:31:02Z
CI_CONCURRENT_PROJECT_ID=0
CI_JOB_NAME_SLUG=netlify
RUNNER_TEMP_PROJECT_DIR=/builds/grouault-projects/learn-gitlab-app.tmp
FF_KUBERNETES_HONOR_ENTRYPOINT=false
CI_PIPELINE_URL=https://gitlab.com/grouault-projects/learn-gitlab-app/-/pipelines/1827931469
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
FF_EXPORT_HIGH_CARDINALITY_METRICS=false
DOCKER_IPTABLES_LEGACY=1
CI_JOB_STARTED_AT=2025-05-20T20:32:23Z
CI_SERVER_VERSION_MINOR=1
CI_RUNNER_DESCRIPTION=1-blue.saas-linux-small-amd64.runners-manager.gitlab.com/default
FF_USE_NEW_BASH_EVAL_STRATEGY=false
FF_DISABLE_UMASK_FOR_KUBERNETES_EXECUTOR=false
FF_MASK_ALL_DEFAULT_TOKENS=true
CI_PROJECT_TITLE=learn-gitlab-app
CI_PROJECT_VISIBILITY=public
CI_COMMIT_TITLE=fix: show env variables
GITLAB_USER_EMAIL=gildasrouault@gmail.com
FF_USE_GIT_BUNDLE_URIS=true
FF_USE_NATIVE_STEPS=false
FF_USE_FLEETING_ACQUIRE_HEARTBEATS=false
CI_SERVER=yes
CI_JOB_GROUP_NAME=netlify
FF_TIMESTAMPS=false
CI_PROJECT_REPOSITORY_LANGUAGES=javascript,css,html
CI_PAGES_URL=https://learn-gitlab-app-20256b.gitlab.io
FF_SET_PERMISSIONS_BEFORE_CLEANUP=true
FF_PRINT_POD_EVENTS=false
CI_SERVER_FQDN=gitlab.com
CI_COMMIT_AUTHOR=Gildas  Rouault <gildasrouault@gmail.com>
CI_JOB_IMAGE=node:22-alpine
CI_RUNNER_SHORT_TOKEN=j1aLDqxS
CI_PAGES_DOMAIN=gitlab.io
CI_JOB_TIMEOUT=3600
CI_REPOSITORY_URL=https://gitlab-ci-token:[MASKED]@gitlab.com/grouault-projects/learn-gitlab-app.git
CI_PROJECT_CLASSIFICATION_LABEL=
CI_PIPELINE_NAME=
CI_COMMIT_BRANCH=feat/smoke-test
GITLAB_ENV=/builds/grouault-projects/learn-gitlab-app.tmp/gitlab_runner_env
FF_USE_POWERSHELL_PATH_RESOLVER=false
FF_GIT_URLS_WITHOUT_TOKENS=false
CI_API_GRAPHQL_URL=https://gitlab.com/api/graphql
CI_RUNNER_ID=12270807
DOCKER_TLS_CERTDIR=
CI_REGISTRY=registry.gitlab.com
CI_DEPENDENCY_PROXY_DIRECT_GROUP_IMAGE_PREFIX=gitlab.com:443/grouault-projects/dependency_proxy/containers
CI_API_V4_URL=https://gitlab.com/api/v4
GITLAB_USER_NAME=Gildas  Rouault
CI_PIPELINE_IID=24
FF_USE_POD_ACTIVE_DEADLINE_SECONDS=true
FF_USE_ADVANCED_POD_SPEC_CONFIGURATION=false
CI_JOB_URL=https://gitlab.com/grouault-projects/learn-gitlab-app/-/jobs/10096934480
CI_SERVER_SHELL_SSH_HOST=gitlab.com
CI_RUNNER_EXECUTABLE_ARCH=linux/amd64
FF_TEST_FEATURE=false
FF_USE_INIT_WITH_DOCKER_EXECUTOR=false
CI_COMMIT_REF_SLUG=feat-smoke-test
CI_DISPOSABLE_ENVIRONMENT=true
PWD=/builds/grouault-projects/learn-gitlab-app
FF_SECRET_RESOLVING_FAILS_IF_MISSING=true
CI_RUNNER_TAGS=["saas-linux-small-amd64"]
CI_SERVER_TLS_CA_FILE=/builds/grouault-projects/learn-gitlab-app.tmp/CI_SERVER_TLS_CA_FILE
CI_PIPELINE_ID=1827931469
CI_PROJECT_PATH_SLUG=grouault-projects-learn-gitlab-app
CI_PROJECT_URL=https://gitlab.com/grouault-projects/learn-gitlab-app
CI_CONFIG_PATH=.gitlab-ci.yml
CI_COMMIT_BEFORE_SHA=f67e9fa90c1d8ac38bcad497f3ad45e4cc8cd15b
CI_PROJECT_NAMESPACE_SLUG=grouault-projects
CI_COMMIT_MESSAGE=fix: show env variables
FF_ENABLE_BASH_EXIT_CODE_CHECK=false
CI_PAGES_HOSTNAME=learn-gitlab-app-20256b.gitlab.io
CI_DEPENDENCY_PROXY_GROUP_IMAGE_PREFIX=gitlab.com:443/grouault-projects/dependency_proxy/containers
GITLAB_USER_ID=25345465
CI_JOB_STATUS=running
CI_JOB_NAME=netlify
CI_SERVER_SHELL_SSH_PORT=22
```


## Script

### before_script
* permet dans un job de mettre des commandes de script avant le bloc script. Cela n'a pas d'impact sur l'exécution mais permet une meilleur lisiblité
* Les commandes peuvent être à un niveau global pour être exécuté sur tous les jobs:
```yaml
default:
  before_script:
    echo "this is executed in all job"
```

### after_script
* est exécuté après la fin du script principal
* permet de lancer des tâches de script mais dans un autre Shell ! (et pas runner)
* utiliser pour le nettoyage ou pour une tâche à exécuter une fois le travail principal terminé

## Stratégies de déploiement

### Principe
Dans une stratégie de déploiement, l'idée est de faire passer l'application par différentes étapes de test. 
Pour cela on utilise différents environnements de tests qui sont un workflow que l'application doit suivre pour pouvoir être déployer dans l'environnement final.
Quand on veut créer une nouvelle version de l'application, cette dernière est transféré dans l'environnement suivant si elle passe les tests, jusqu'à l'environnement final.

### Type Environnements
#### dévelopement

<img src="./img/dev-env.png" />

#### test
<img src="./img/test-env.png" />

#### staging
<img src="./img/staging-env.png" />

```yaml
netlify_staging:
  image: node:22-alpine
  stage: deploy_staging
  rules:
    - if: $CI_DEFAULT_BRANCH == $CI_COMMIT_REF_NAME
  before_script:
    - npm install -g netlify-cli@20.1.1
    - apk add curl
  script:
    - netlify --version
    - netlify status
    - echo "Deploying to site id ${NETLIFY_SITE_ID}"
    - netlify deploy --alias staging --dir=build
    - curl 'https://staging--grouault-learn-gitlab.netlify.app/' | grep 'GitLab'
```

#### prod
<img src="./img/prod-env.png" />

```yaml
netlify_prod:
  image: node:22-alpine
  stage: deploy_prod
  rules:
    - if: $CI_DEFAULT_BRANCH == $CI_COMMIT_REF_NAME
  before_script:
    - npm install -g netlify-cli@20.1.1
    - apk add curl
  script:
    - netlify --version
    - netlify status
    - echo "Deploying to site id ${NETLIFY_SITE_ID}"
    - netlify deploy --prod --dir=build
    - curl 'https://grouault-learn-gitlab.netlify.app/' | grep 'GitLab'
```

### Continuous Delivery / Continuous Deployment

Dans certains cas, voir même souvent le déploiement sur l'environnement final doit se faire manuellement ; cela peut s'avérer nécessaire pour plusieurs raisons.

* s'assurer de la qualité par des tests qui nécessitent des contrôles humains
<img src="./img/quality-assurance.png" />
* gestion des risques

Avant le déploiement, il faudra vérifier que tous les risques ont été pris en compte
<img src="./img/manage_risk.png" />

* contrôle réglementaire ou de conformité
Le contrôle manuel permet de s'assurer ici que tous les contrôles requis sont effectués et documentés
<img src="./img/regulatory-compliance.png" />

* Stakeholder approbation
Certains changements peuvent avoir un impact important sur le business de l'entreprise et peuvent nécessiter un consensus avant le déploiement final.

<img src="./img/steackholders-sign-off.png" />

#### Manual
```yaml
netlify_prod:
  image: node:22-alpine
  stage: deploy_prod
  when: manual
```

#### Définition
Continuous Delivery
* pipeline entièrement automatisé ; l'ensemble du processus de build, de test et de déploiement de l'application est automatisé.
	* réduit le risque d'erreur humaine
	* rend le processus plus efficace
* la pipeline créée des builds prêts pour la production même s'il demeure une étape d'approbation à la fin (simple clic pour le déploiement) qui ne nécessite pas de travail manuel.
* dans ce mode, il devrait toujours y avoir une version disponible  prête à déployer en prod

Continuous Deployement
* s'appuie la 'livraison continue' mais sans étape d'approbation manuelle
* si les changements passent la pipeline et que toutes les vérifications sont positives, le changement est déployé en production.

### Preview environnement
Environnement particulier et temporaire pour voir les changements spécifiques d'une merge request.

<img src="./img/preview-env.png" />

## Environnement

environnement
* L'idée est de lier GitLab à l'infrastructure en associant une URL à un environnement.
* permet d'avoir plus d'information sur l'environnement à travers GitLab
* Cela permet à GitLab de suivre les déploiements et de gérer des fonctionnalités comme les retours en arrière et les approbations, facilitant ainsi une gestion efficace des environnements.
### DotEnv
report spécifique dans lequel il est possible de stocker des variables d'environnement permettant ainsi le passage/partage d'informations.
Au niveau de la configuration, il faut définir au même niveau que le script, l'artifact DotEnv. Le fait de définir le fichier et de l'associer à l'artifiact le rend disponible dans l'environnement.

```yaml
  artifacts:
    reports:
      dotenv: deploy.env
```

### Définir un environnement
Pour définir un environnement via le fichier gitlab-ci.yaml, il suffit de le définir de la manière suivante avec un nom et une url :
```yaml
environment: 
  name: preview/$CI_COMMIT_REF_SLUG 
  url: $REVIEW_URL
```
Les valeurs de l'environnement sont alors accessibles avec les clés suivantes:
- $CI_ENVIRONNEMENT_URL
- $CI_ENVIRONNEMENT_NAME

L'autre manière est juste de déclarer l'environnement et de faire l'association de l'url via l'interface GitLab
``` yaml
environment: production
```
### Static vs Dynamic
Pour les environnement de Preview, on associe à chaque MR un environnement dynamique basé sur le nom de la branche. 
Pour les environnements static, comme staging ou prod, l'envionnement sera fixe et ciblé par une URL unique non variabilisé.
```yaml
netlify_review:
  image: node:22-alpine
  stage: deploy_review
  rules:
    - if: $CI_DEFAULT_BRANCH != $CI_COMMIT_REF_NAME
  before_script:
    - npm install -g netlify-cli@20.1.1
    - apk add curl jq
  environment:
    name: preview/$CI_COMMIT_REF_SLUG 
    url: $REVIEW_URL
  script:
    - netlify --version
    - netlify status
    - echo "Deploying to REVIEW site id ${NETLIFY_SITE_ID}"
    - netlify deploy --dir=build --json > deploy-result.json
    - REVIEW_URL=$(jq -r '.deploy_url' deploy-result.json)
    - echo $REVIEW_URL
    - curl $REVIEW_URL | grep 'GitLab'
    - echo "REVIEW_URL=$REVIEW_URL" > deploy.env
    - cat deploy.env
  artifacts:
    reports:
      dotenv: deploy.env
```

### Variables

#### scope variable
* Il est possible d'avoir différentes variables pour chaque environnement défini
* il est possible de définir la même clé par environnement avec une valeur distincte pour chaque environnement.

