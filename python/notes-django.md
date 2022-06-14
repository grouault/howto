[home](index.md)

# DJANGO

## Installation

<pre>
pip install django
</pre>

## Structure du projet

TODO

## Création et lancement du projet

### créer un projet

<pre>
django-admin startproject pizzamama
</pre>

### lancer le projet

#### lancement manuel

    * se déplacer dans le folder racine du projet
    <pre>
    pizzamama> python manage.py runserver
    </pre>

#### via la configuration pour debugger

    * [PyCharm] - faire une config, via le menu editconfiguration
    <pre>
        scriptpath: manage.py
        parameters: runserver
    </pre>

### interface d'administration

#### Principe

- il s'agit de l'interface permettant d'administrer l'application
  <pre>
  http://127.0.0.1:8000/admin/
  </pre>

#### création d'un user admin

  <pre>
  > python manage.py createsuperuser
  </pre>

==> local: admin/admin/ gildasrouault@gmail.com
==> remote: admin/Pizza-35

## créer une application (app django)

### principe

- une app permet de gérer une partie fonctionnelle du site
- un projet peut contenir une ou plusieurs app

### création

- crée un répertoire menu qui contient la structure de l'app
  <pre>
  > python manage.py startapp menu
  </pre>

### enregistrement de l'app

- enregistrer l'application au niveau du projet
  Dans le fichier settings.py
  <pre>
  INSTALLED_APPS = [
      'django.contrib.admin',
      'django.contrib.auth',
      'django.contrib.contenttypes',
      'django.contrib.sessions',
      'django.contrib.messages',
      'django.contrib.staticfiles',
      'menu.apps.MenuConfig',
  ]
  </pre>
- l'enregistrement est indispensable si le modèle est modifié

### models.py et structure de données

#### principe

- le modèle correspond à la structure de données que l'on veut gérer au niveau de l'app.
- pour cela, on créer une class Python modélisant le modèle que l'on veut utiliser
- ensuite django prend en charge la gestion du modèle au niveau :
  - base de données
  - interface administration

#### création

- création d'une classe Pizza que django devra gérer
<pre>
  from django.db import models

  class Pizza(models.Model):
      nom = models.CharField(max_length=200)
      ingredients = models.CharField(max_length=400)
      prix = models.FloatField(default=0)
      vegetarienne = models.BooleanField(default=False)

      def __str__(self):
          return self.nom
</pre>

#### migration de la base de données

##### principe de la migration

- la migration permet d'appliquer les changements du modèle sur la base de données
- la migration permet de tenir compte des changements faits au niveau du modèle
  et de migrer les données en tenant compte des mises à jour du modèle
- lancer la commande suivante pour migrer le modèle de données :
  <pre>
    > python manage.py makemigrations
  </pre>
- un ficher est créé dans la structure de l'app au niveau du folder 'migration'

##### appliquer les changements sur la base de données

- une fois les fichiers générés (dans le répertoire migration),
  il faut appliquer les changements sur la base
  <pre>
    > python manage.py migrate
  </pre>

#### admin.py

- Ajouter la gestion des pizzas dans l'écran d'administration

##### PizzaAdmin: ajouter la pizza à l'interface

- fichier admin.py
  <pre>
    from .models import Pizza
  
    # Register your models here.
    admin.site.register(Pizza)
  </pre>

##### PizzaAdmin : customiser l'interface d'admin pour pizza

- permet de customiser l'interface
  <pre>
  class PizzaAdmin(admin.ModelAdmin):
      # nom à afficher dans l'admin
      list_display = ('nom','ingredients', 'vegetarienne', 'prix')
      # définir des filtres de recherche
      search_fields = ['nom']
  
  # Register your models here.
  admin.site.register(Pizza, PizzaAdmin)
  </pre>

## View / Contrôleur

### Configuration de la vue

#### vue: principe

- la vue fait office de contrôleur
- la vue va recevoir les requête http
- la vue retourne une réponse http

#### view.py

- Dans ce fichier, on écrit l'ensemble de nos vues.

##### vue qui renvoit du texte

<pre>
  from django.shortcuts import render
  from django.http import HttpResponse
  
  # définition de la vue
  # pour l'instant, retourne un texte
  def index(request):
      return HttpResponse("Les pizzas")
</pre>

##### view et HTML

- vue qui renvoit du Html via un template
<pre>
def index(request):
    # trier les pizzas
    pizzas = Pizza.objects.all().order_by('prix')
    # sorted_pizzas = sorted(list(pizzas), key=sorted_price)
    # print(sorted_pizzas)
    # trier les pizzas

    return render(request, 'menu/index.html', {'pizzas': pizzas})
</pre>

##### view et JSon

- du Json c'est du texte...
<pre>
  from django.http import HttpResponse
  from django.core import serializers

  def api_get_pizzas(request):
      pizzas = Pizza.objects.all().order_by('prix')
      pizzas_json = serializers.serialize("json", pizzas)
      return HttpResponse(pizzas_json)
</pre>

##### View Recuperation des datas

- On récupère les datas au niveau de la vue pour les transmettres en général à un template pour traitement
<pre>
    # recuperer les datas dans la vue
    pizzas = Pizza.objects.all()
    pizzas_names = [pizza.nom for pizza in pizzas]
    pizzas_names_str = ", ".join(pizzas_names)
    return HttpResponse("Les pizzas : " + pizzas_names_str)
</pre>

## View / Urls

### Principe

- il faut indiquer à django comment accéder aux vues via les urls

### Configuration des urls / views

- il existe deux niveau de configurations
  - un au niveau projet
  - un au niveau app

#### configuration au niveau projet

- au niveau projet, on définit un premier niveau de configuration de l'url.
- chaque niveau fait alors référence à un fichier de configuration spécifique de l'app.
- ainsi dans l'exemple ci-après, la configuration pour l'url menu/ signifie:

  - les vues liées aux urls suivantes :
    <pre>
    http://127.0.0.1:8000/menu/...
    </pre>
  - sont traitées par dans le fichier urls de l'app 'menu'
    <pre>
      from django.contrib import admin
      from django.urls import path, include
    
      urlpatterns = [
        path('admin/', admin.site.urls),
        path('menu-pizza/', include('menu.urls')),
        path('api/', include('menu.api_urls')),
        path('', include('main.urls')),
      ]
    </pre>

#### configuration au niveau app

- au niveau app, on peut créer un ou plusieurs fichiers de configuation
  Exemple pour l'app menu :
  - un fichier de configuraiton pour les urls applicatives
    - répond aus urls host/menu/...
  - un fichier de configuration pour les ursl api:
    - répond aus urls host/api/...
- il faut créer le fichier :
  <pre>
    menu/urls.py
    menu/urls_api.py
  </pre>

- IMPORTANT :

  - il faut définir un name-space pour la configuration des liens dans les fichiers html.
  - le name-space sert à differencier 2 urls qui ont le même nom dans deux fichiers de configuration différents
    exemple:
    - app menu : index est le nom de l'url par défaut
    - app main : index est aussi le nom de l'url par défaut
  - on utilise la variable suivante pour définir le namespace
      <pre>
      - app_name => on reprend en général le nom de la configuraiton de premier niveau
      </pre>

  - Exemple de configuration
    <pre>
      from django.urls import path
      from . import views
    
      # IMPORTANT: namespace
      app_name = "menu"
    
      urlpatterns = [
          # '': définit la sous-adresse chaine vide indique index
          # name: permet de referencer l'url dans le html
          path('', views.index, name="index"),
    
      ]
    </pre>

  - Lien dans une page html
    - on utilise le name-space pour faire le lien
      ```
        <a href="{% url 'menu:index' %}">Voir le menu</a>
      ```

## Template

### principe

- permet de créer du HTML

### configuration

- créer le folder : menu/templates (mot clé pour Django)
- créer un sous-répertoire menu(du nom de l'application)

  - sera utile pour référencer les templates de même nom

    - en effet, django parcours tous les folders template de chaque app
    - il prend alors le premier qui répond à la signature
    - la différentiation se fera alors sur le sous-dossier
    <pre>
      # avec sous dossier et différentiation possible
      menu/templates/menu/index.html
      main/templates/main/index.html
      
      # sans sous dossier et pas de différenciation possible
      ==> si pas de sous dossier
      menu/templates/index.html
      main/templates/index.html

    </pre>

- il faut transformer la vue pour qu'elle puisse appeler le template
- render :dans le fichier views.py

  - permet d'aller chercher un template et d'en faire le rendu
  <pre>
    from django.shortcuts import render
    from django.http import HttpResponse
  
    # vue qui pointe vers le template
    def index(request):
        return render(request, 'menu/index.html')
  </pre>

### passer des données au Template

- sous la forme d'un dictionnaire
  <pre>
    return render(request, 'menu/index.html',{'pizzas': pizzas)
  </pre>
- dans le template:
  ```
  <ul>
  {% for pizza in pizzas %}
  <li>{{pizza.nom}}</li>
  {% endfor %}
  </ul>
  ```

## fichier statique

### répertoire static

- créer le répertoire au niveau de l'application
  <pre>
  # attention: static est un mot-clé pour python
  menu/static
  </pre>
- créer un fichier de style
  <pre>
  menu/static/menu/style.css
  </pre>

### référence dans les templates

- charger le fichier à partir du fichier index.html
- il faut utiliser le mot clé static
- les chemins sont définis en relatif par rapport au dossier static
  ```
    <!DOCTYPE html>
    {% load static %}
    <html lang=fr>
    <head>
        <meta charset="UTF-8">
        <title>Menu des pizzas</title>
        <link rel="stylesheet" href="{% static 'menu/style.css' %}">
    </head>
  ```

### ajout des images

- créer un répertoire d'images
  <pre>
  menu/static/images
  </pre>

- dans le CSS
  <pre>
  body{
      background: url("images/menu_background.jpg") no-repeat;
  }
  </pre>

## Création d'un API:

### view.py utilisation d'un serializer JSon

- créer une api dans views.py de l'app
  <pre>
  from django.core import serializers
  
  def api_get_pizzas(request):
    pizzas = Pizza.objects.all().order_by('prix')
    pizzas_json = serializers.serialize("json", pizzas)
    return HttpResponse(pizzas_json)
  </pre>

### url_api.py : définir les endpoints

- on définit un nouveau fichier pour avoir un nouvel endpoint
  <pre>
  app_name = "api"
  
  urlpatterns = [
      path('pizzas', views.api_get_pizzas)
  ]
  </pre>

- modifier url.py
<pre>
  urlpatterns = [
      path('admin/', admin.site.urls),
      path('menu-pizza/', include('menu.urls')),
      path('api/', include('menu.api_urls')),
      path('', include('main.urls')),
  ]
</pre>

### appel de l'api en mode console

<pre>
  import requests
  import json
  import urllib3
  # ATTENTION : manque certificat SSL
  urllib3.disable_warnings()
  
  url = "https://giropizzamamadjango.herokuapp.com/api/pizzas"
  
  data = requests.get(url, verify=False);
  
  
  # serialisation json en mode console
  # transforme le flux en dictionnaire
  pizzas = json.loads(data.text)
  for pizzaModel in pizzas:
      pizza = pizzaModel.get('fields')
      print(pizza.get('nom'))
</pre>
