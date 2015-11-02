CREATE OR REPLACE FUNCTION update_films() 
RETURNS VOID AS $$
DECLARE cursor_film CURSOR FOR SELECT * FROM films FOR UPDATE;
        current_film films%ROWTYPE;
BEGIN
    OPEN cursor_film;
    FETCH FIRST FROM cursor_film INTO current_film;
    WHILE FOUND = TRUE LOOP
        RAISE NOTICE 'Le nom est %.', current_film.title;
    	
		UPDATE  films
        SET     publics = getNewValue(current_film.publics)
        WHERE   CURRENT OF cursor_film;
    
        FETCH NEXT FROM cursor_film INTO current_film;
    
	END LOOP;
    CLOSE cursor_film;
END;
$$ LANGUAGE PLPGSQL;