-- modifier un certaines nombre de paramètres

-- modifier l'espace disque
-- modifier la taille des fichiers de données
ALTER DATABASE GESCOM MODIFY FILE (name=gescom_data, size= 20MB);
