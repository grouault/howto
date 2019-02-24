-- Ajout d'une colonne
ALTER TABLE CLIENTS ADD CODEREP char(2) NOT NULL;
-- Modification d'une colonne existante
ALTER TABLE CLIENTS ALTER COLUMN TELEPHONE char(14) NOT NULL;