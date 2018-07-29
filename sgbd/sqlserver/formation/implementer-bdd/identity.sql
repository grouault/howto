-- # type identity
-- séquence : on peut avoir des absences dans la séquences
CREATE TABLE CATEGORIES(
  code_cat int identity(100,1);
  libelle_cat nvarchar(200)
);
