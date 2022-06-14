## HEROKU

[home](index.md)

## se connecter sur heroku

### 1- configuration PROXY

#### windows

<pre>
set HTTP_PROXY=http://login:password@10.3.0.101:8080
set HTTPS_PROXY=https://login:password@10.3.0.101:8080
</pre>

#### linux

<pre>
  $ export http_proxy=https://login:password@10.3.0.101:8080"
  $ export https_proxy=https://login:password@10.3.0.101:8080"

  $ unset http_proxy
  $ unset https_proxy

  vérifier avec 
    $ printenv 
    $ printenv https_proxy
</pre>

### 2- login

<pre>
  heroku login -i
  > gildasrouault@gmail.com
  > Herokuku-22
</pre>

### 3- sourcer sur l'environnement virtuel s'il exsite

- windows
<pre>
    C:\Services\formation\python\projects\test-env
    (venv) λ .\venv\Scripts\activate
</pre>
- linux
<pre>
grouault@N058176 /c/Services/formation/python/projects/PizzaMamaDjango
λ source venv/Scripts/activate
</pre>

## Déployer un projet

- 8 étapes à réaliser à chaque projet que l'on souhaite publier

### 1- gunicorn

- module à installer

### 2- fichier Procfile:

- fichier que Heroku va utiliser pour exécuter notre projet

### 3- Django-Heroku

- sert pour les paramètrages base de données

### 4- Fichier statique

### 5- requirements

- expliquer à Heroku tous les paquets dont on a besoin
  <pre>
  pip freeze: 
  </pre>
  liste les paquets utilisés par notre projet

### 6- initialisation de GIT

#### initialiser le projet GIT

<pre>
> git init
</pre>

#### .gitignore

- Créer et initialiser le fichier .gitignore
<pre>
  - fichier sqlite : en prod c géré avec une base postgre
  - **pycache** : fichier de cache géré par le projet
</pre>

### 7- Création du projet HEROKU

- créer le projet sur heroku et attacher le projet sur le gestionnaire git en remote
- après un git .init, le projet n'est lié à aucun remote projet

```
  (venv) λ git remote -v
  ==> Result
  heroku  https://git.heroku.com/giropizzamamadjango.git (fetch)
  heroku  https://git.heroku.com/giropizzamamadjango.git (push)
```

#### heroku create

- la commande heroku de création fera le rattachement au repo remote git créé

```
  # se placer au niveau du projet
  C:\Services\formation\python\projects\PizzaMamaDjango

  # créer le projet sur heroku
  (venv) λ heroku create giropizzamamadjango
    ==> Résultat
    Creating ⬢ giropizzamamadjango... done

    # url d'accès au site web
    https://giropizzamamadjango.herokuapp.com/ |

    # url des sources GIT
    https://git.heroku.com/giropizzamamadjango.git

```

- Lancer la commande suivante si le projet n'est pas encore lié à un remote repo
  et que ce dernier existe.

```
  C:\Services\formation\python\projects\PizzaMamaDjango\pizzamama (master)
  (venv) λ heroku git:remote -a giropizzamamadjango

  ==> Result
  set git remote heroku to
  https://git.heroku.com/giropizzamamadjango.git
  https://git.heroku.com/giropizzamamadjango.git
```

#### heroku open

<pre>
# permet de lancer le projet
(venv) λ heroku open
</pre>

### 8- settings.py

- indiquer à Django l'url qui va permettre d'accéder à l'application
- celle généré au step-7
- il faut redéployer le projet
<pre>
  ALLOWED_HOSTS = ['giropizzamamadjango.herokuapp.com']
</pre>

### 10- migrer la base sur heroku

- exécuter une commande sur le serveur Heroku
<pre>
> heroku run python manage.py migrate
</pre>

### 11- créer le compte admin sur heroku

<pre>
heroku run python manage.py createsuperuser
admin / Pizza-35
</pre>
