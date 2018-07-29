-- modifier un certaines nombre de paramètres

-- modifier l'espace disque
-- modifier la taille des fichiers de données
ALTER DATABASE GESCOM MODIFY FILE (name=gescom_data, size= 20MB);
-- ==> taille initiale>max_size : pas trop grave car lu quand on veut agrandir le fichier de données.

-- ajouter un fichier
ALTER DATABASE 
ADD FILE(
    name=gescom_data2, 
    filename='c:\donnees\gescom_data2.ndf',
    size=20MB);


