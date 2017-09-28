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
