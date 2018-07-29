- # contraintes d'intégrité
- permettre de garantir l'intégrité des données
- mettre en place une structure qui permet à sql_server de travailler correctement et d'appliquer les différentes formes normales 
- cad s'assurer que les données sont conformes aux règles de gestion fixées par le modèle relationnel.


- 1- clé primaire: 
- plus petite clé d'identification possible dans une table

- 2 : unicité ou clé secondaire
- ne pas avoir deux lignes qui possèdent exactement la même contrainte
- ex: ne pas avoir deux clients ayant le même nom et numéro de téléphone
- ex: un email

- 3: clé étrangère
- contrainte d'intégrité référentiel
- référence la clé primaire d'une autre table
- permet de lier la structure de deux tables

- 4: contraintes de validation
- contrainte de type check:
- ex: prix d'un article est bien positif
- sur une ligne courante, s'assurer que cette validation est bien faite.
