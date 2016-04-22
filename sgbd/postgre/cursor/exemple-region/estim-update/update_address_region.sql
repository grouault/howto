--
-- Script de mise à jour des adresses
-- pour referencer les nouvelles regions.
-- 3008 : champagne ardennes ==> 3001
-- 3017 : Lorraine ==> 3001
-- 3016 : Limousin ==> 3002
-- 3023 : Poitou charente ==> 3002
-- 3026 : Rhône-Alpes ==> 3003
-- 3013 : Haute-Normandie ==> 3004
-- 3011 : Franche-comté ==> 3005
-- 3019 ! Midi-Pyrénées ==> 3015

CREATE OR REPLACE function update_address_region()
RETURNS VOID AS $$ 
DECLARE cursor_address CURSOR FOR 
	SELECT * 
	FROM address a
	FOR UPDATE;
	current_address address%ROWTYPE;
	newValueRegion BIGINT;
BEGIN
	OPEN cursor_address;
    FETCH FIRST FROM cursor_address INTO current_address;
    WHILE FOUND = TRUE LOOP
		newValueRegion := 0;		
		IF current_address.regionid=3008 THEN
			-- 3008 : champagne ardennes ==> 3001
			newValueRegion := 3001;
		ELSIF current_address.regionid=3017 THEN
			-- 3017 : Lorraine ==> 3001
			newValueRegion := 3001;
		ELSIF current_address.regionid=3016 THEN
			-- 3016 : Limousin ==> 3002		
			newValueRegion := 3002;
		ELSIF current_address.regionid=3023 THEN
			-- 3023 : Poitou charente ==> 3002		
			newValueRegion := 3002;		
		ELSIF current_address.regionid=3026 THEN
			-- 3026 : Rhône-Alpes ==> 3003		
			newValueRegion := 3003;		
		ELSIF current_address.regionid=3013 THEN
			-- 3013 : Haute-Normandie ==> 3004		
			newValueRegion := 3004;		
		ELSIF current_address.regionid=3011 THEN
			-- 3011 : Franche-comté ==> 3005		
			newValueRegion := 3005;
		ELSIF current_address.regionid=3019 THEN
			-- 3019 ! Midi-Pyrénées ==> 3015
			newValueRegion := 3015;				
		ELSE
			newValueRegion := 0;	
		END IF;
		-- UDPDATE de la table
		IF newValueRegion > 0 THEN
			UPDATE address 
				SET regionid = newValueRegion 
				WHERE CURRENT OF cursor_address;
		END IF;	
		
		FETCH NEXT FROM cursor_address INTO current_address;
		
	END LOOP;
    CLOSE cursor_address;
END
$$ LANGUAGE PLPGSQL;