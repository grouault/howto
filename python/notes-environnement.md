## Python

[home](index.md)

### install Python

Location :
C:\Program Files (x86)\Python\Python310
C:\Program Files (x86)\Python\Python310

## PIP

- pip est un module python

### INSTALLATION

#### pip.ini

Ce fichier est à créer s'il n'existe pas
Ce ficher peut-être créer :

- de manière globale
  - emplaceement : C:\ProgramData\pip
  - configuration globale :
    - la configuration suivante permet d'éviter les erreurs SSL
    <pre>
    [global]
    trusted-host = pypi.python.org
                pypi.org
                files.pythonhosted.org
    </pre>
- de manière local
- pour une environnement virtuel

## Commande:

- pip config list
- pip install nom_package
- pip uninstall nom_package
- pip list
- pip freeze

## Environnement Virtuel (venv)

### Définition

- environnement virtuel qui permet de définir une configuration pour le projet.

### Process de création pour un projet

#### Création

- Créer un environnement virtuel manuellement
- utilisation du module venv et initialistion du folder venv
- seul les package/modules nécessaires sont recopiés (pip list)
<pre>
  > python -m venv venv
</pre>
- architecture:
  - include
  - lib : endroits ou les modules vont être instatllés
  - scripts : copie des fichiers qui correspondent à l'installation de python sur la machine

#### Activation

- activate : pour activer l'environnement

* windows
<pre>
    C:\Services\formation\python\projects\test-env
    (venv) λ .\venv\Scripts\activate
</pre>
* linux
<pre>
grouault@N058176 /c/Services/formation/python/projects/PizzaMamaDjango
λ source venv/Scripts/activate
</pre>

- deactivate: pour réactiver la config globale:
<pre>
    C:\Services\formation\python\projects\test-env
    (venv) λ deactivate
    C:\Services\formation\python\projects\test-env
</pre>

## Configurations (Pyenv)
