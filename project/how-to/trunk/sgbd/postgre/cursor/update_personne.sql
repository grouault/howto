CREATE OR REPLACE FUNCTION misajour() 
RETURNS VOID AS $$
DECLARE c_personnes SCROLL CURSOR FOR SELECT * FROM personnes FOR UPDATE;
        r_personnes    personnes%ROWTYPE;
BEGIN
    OPEN c_personnes;
    FETCH FIRST FROM c_personnes INTO r_personnes;
    WHILE FOUND = TRUE LOOP
        RAISE NOTICE 'Le nom est %.', r_personnes.nom;
        UPDATE    personnes
        SET     nom = UPPER(nom)
        WHERE    CURRENT OF c_personnes;
       
        FETCH NEXT FROM c_personnes INTO r_personnes;
    END LOOP;
    CLOSE c_personnes;
END;
$$ LANGUAGE PLPGSQL;

