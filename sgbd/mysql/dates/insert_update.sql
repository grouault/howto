-- insert dates
--
INSERT INTO SchemaHoraire (dateCreation, dateModification, , col_date) VALUE ('DATE: Auto CURDATE()', CURDATE() )

-- Update
--
UPDATE SchemaHoraire 
    SET dateCreation=CURDATE(), 
        dateModification=CURDATE(),
        utilisateurCreation='SYSTEM', 
        utilisateurModification='SYTEM';

INSERT INTO SchemaHoraire (dateValidite, ressourceId, dateCreation, dateModification, utilisateurCreation, utilisateurModification) 
    VALUES (CAST('2017-07-01' AS DATE), 26223, CURDATE(), CURDATE(), 'SYTSEM', 'SYSTEM');

