-- simple et unique
CREATE TABLE nom_table (
    colonne1 INT KEY,                  -- Crée un index simple sur colonne1
    colonne2 VARCHAR(40) UNIQUE,       -- Crée un index unique sur colonne2
);

-- pk et simple
CREATE TABLE nom_table (
    colonne1 description_colonne1,
    [colonne2 description_colonne2,
    colonne3 description_colonne3,
    ...,]
    [PRIMARY KEY (colonne_clé_primaire)],
    [INDEX [nom_index] (colonne1_index [, colonne2_index, ...])]
)
[ENGINE=moteur];

-- Exemple                                
CREATE TABLE Animal (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    espece VARCHAR(40) NOT NULL,
    sexe CHAR(1),
    date_naissance DATETIME NOT NULL,
    nom VARCHAR(30),
    commentaires TEXT,
    PRIMARY KEY (id),
    INDEX ind_date_naissance (date_naissance),  -- index sur la date de naissance
    INDEX ind_nom (nom(10))                     -- index sur le nom (le chiffre entre parenthèses étant le nombre de caractères pris en compte)
)
ENGINE=INNODB;
