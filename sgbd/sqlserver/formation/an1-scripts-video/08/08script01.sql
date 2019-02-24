CREATE TABLE employes(
  id int identity (1,1),
  position hierarchyId,
  nom nvarchar(80),
  prenom nvarchar(80),
  poste nvarchar(80));
GO
ALTER TABLE employes
 ADD CONSTRAINT pk_employes PRIMARY KEY (id);
CREATE INDEX employes_position
  ON employes(position);
-- modifier la table pour ajouter une colonne relative au niveau
ALTER TABLE employes
  ADD niveau AS position.GetLevel();  
CREATE INDEX employes_niveau
  ON employes(niveau, position);
GO
-- Ajouter le sommet de la hiérarchie
INSERT INTO employes (position, nom,prenom, poste) VALUES 
  (hierarchyId::GetRoot(), 'DUPONT','Emile','Directeur');
  
DECLARE @patron hierarchyid; 
SELECT @patron=hierarchyid::GetRoot() FROM employes;
-- Ajouter le second niveau
DECLARE @drh hierarchyid;
DECLARE @compta hierarchyid
SET @drh=@patron.GetDescendant(null, null);
INSERT INTO employes (position, nom, prenom, poste) VALUES
    (@drh,'BARTIN','Jeanne','DRH');
SET @compta=@patron.GetDescendant(@drh, null);
INSERT INTO employes (position, nom, prenom, poste)  VALUES 
  ( @compta,'MICHALON','Paul','Comptable');
-- ajouter un troisième niveau
INSERT INTO employes (position, nom, prenom, poste) VALUES
  (@drh.GetDescendant(null, null),'BERNAUD','Beatrice','Assistante');
INSERT INTO employes ( position, nom, prenom, poste) VALUES
  (@compta.GetDescendant(null, null),'MARBOT','Marcel','Assistant');
GO
DECLARE @chef hierarchyid;
SELECT @chef=hierarchyid::GetRoot() FROM employes

SELECT *
  FROM employes
  WHERE position.GetAncestor(1)=@chef;