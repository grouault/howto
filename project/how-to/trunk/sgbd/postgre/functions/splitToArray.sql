--
-- Permet de retourner un tableau de valeur.
CREATE OR REPLACE FUNCTION getNewValue ()
RETURNS integer[] AS
$body$
declare
	publicsStr varchar;
	ids		   integer[];
BEGIN

	SELECT publics
		FROM films
		WHERE code = 'UA502' INTO publicsStr;

	ids = regexp_split_to_array(publicsStr, '#');	
	RETURN ids;	
	
END;
$body$
LANGUAGE 'plpgsql';

--
-- Permet de retourner les valeurs d'un tableau concaténées.
CREATE OR REPLACE FUNCTION getNewValue ()
RETURNS VARCHAR AS
$body$
declare
	publicsStr varchar;
	newValue   varchar;
	ids		   integer[];
	currentId  integer;
BEGIN

	SELECT publics
		FROM films
		WHERE code = 'UA502' INTO publicsStr;
		
	ids = regexp_split_to_array(publicsStr, '#');
	newValue := '';
	
	FOREACH currentId IN ARRAY ids
	LOOP
		IF newValue = '' THEN
			newValue := CAST(currentId AS VARCHAR(16));
		ELSE
			newValue := newVAlue || ';' ||  CAST(currentId AS VARCHAR(16));
		END IF;
		RAISE NOTICE 'currentId : %.', currentId;
		RAISE NOTICE 'newValue : %.', newValue;
	END LOOP;
	RETURN newValue;	
	
END;
$body$
LANGUAGE 'plpgsql';

--
-- Permet de retourner les valeurs d'un tableau concaténées.
CREATE OR REPLACE FUNCTION getNewValue ()
RETURNS VARCHAR AS
$body$
declare
	publicsStr varchar;
	newValue   varchar;
	currentValue varchar;
	ids		   integer[];
	currentId  integer;
BEGIN

	SELECT publics
		FROM films
		WHERE code = 'UA502' INTO publicsStr;
		
	ids = regexp_split_to_array(publicsStr, '#');
	newValue := '';
	currentValue := '';
	
	FOREACH currentId IN ARRAY ids
	LOOP
		RAISE NOTICE 'currentId : %.', currentId;
		select getpropertyvalue('code', currentId) into currentValue;
		RAISE NOTICE 'currentValue : %.', currentValue;
		IF newValue = '' THEN
			newValue := currentValue;
		ELSE
			newValue := newVAlue || ';' ||  currentValue;
		END IF;
		RAISE NOTICE 'newValue : %.', newValue;
		RAISE NOTICE '------';
	END LOOP;
	RETURN newValue;	
	
END;
$body$
LANGUAGE 'plpgsql';

--
-- Permet de retourner les valeurs d'un tableau concaténées.
-- Avec paramètre : 
CREATE OR REPLACE FUNCTION getNewValue (
	catIds varchar
)
RETURNS VARCHAR AS
$body$
declare
	publicsStr varchar;
	newValue   varchar;
	currentValue varchar;
	currentId  integer;
	ids	integer[];
BEGIN
		
	ids = regexp_split_to_array(catIds, '#');
	newValue := '';
	currentValue := '';
	
	FOREACH currentId IN ARRAY ids
	LOOP
		RAISE NOTICE 'currentId : %.', currentId;
		select getpropertyvalue('code', currentId) into currentValue;
		RAISE NOTICE 'currentValue : %.', currentValue;
		IF newValue = '' THEN
			newValue := currentValue;
		ELSE
			newValue := newVAlue || ';' ||  currentValue;
		END IF;
		RAISE NOTICE 'newValue : %.', newValue;
		RAISE NOTICE '------';
	END LOOP;
	RETURN newValue;	
	
END;
$body$
LANGUAGE 'plpgsql';