-- change values RANDOM STRING
UPDATE Ressource SET fonction = ELT(1 + FLOOR(RAND()*4), 1, 2, NULL);
