--
-- Cursor
--
CREATE OR REPLACE FUNCTION update_service_deporte_filter(
	createdDateParam VARCHAR
) 
RETURNS VOID AS $$
DECLARE cursor_sdep CURSOR FOR SELECT * 
						FROM estim_portail_servicedeporte sDep
						WHERE sDep.createddate < to_date(createdDateParam, 'DD-MM-YYYY')
						FOR UPDATE;
        current_sdep estim_portail_servicedeporte%ROWTYPE;
		newValuePublics VARCHAR;
		newValueThematiques VARCHAR;
		newValueRegions VARCHAR;
		newValueStructures VARCHAR;
		
BEGIN
    OPEN cursor_sdep;
    FETCH FIRST FROM cursor_sdep INTO current_sdep;
    WHILE FOUND = TRUE LOOP
	
		-- RAISE NOTICE '[SDEP] - id = %.', current_sdep.servicedeporteid;
		newValuePublics := '';
		newValueThematiques := '';
		newValueRegions := '';
		newValueStructures := '';
		
		IF LENGTH(current_sdep.publics_cibles) > 0 THEN
			newValuePublics := lower(getLabelsCategory(current_sdep.publics_cibles));
		END IF;
		
		IF LENGTH(current_sdep.thematiques) > 0 THEN
			newValueThematiques := lower(getLabelsCategory(current_sdep.thematiques));
		END IF;

		IF LENGTH(current_sdep.regions) > 0 THEN
			newValueRegions := lower(getLabelsRegion(current_sdep.regions));
		END IF;
		
		IF LENGTH(current_sdep.structures) > 0 THEN
			newValueStructures := lower(getLabelStuctures(current_sdep.structures));
		END IF;		
		
		/*
		RAISE NOTICE '-----------------------------------------';
		RAISE NOTICE 'sDep = %.', current_sdep.servicedeporteid;
		RAISE NOTICE 'newValuePublics = %.', newValuePublics;
		RAISE NOTICE 'newValueThematiques = %.', newValueThematiques;
		RAISE NOTICE 'newValueRegions = %.', newValueRegions;
		RAISE NOTICE 'newValueStructures = %.', newValueStructures;
		RAISE NOTICE '-----------------------------------------';
		*/
		
		UPDATE estim_portail_servicedeporte
			SET thematiques = newValueThematiques, publics_cibles = newValuePublics,
				regions = newValueRegions, structures = newValueStructures
			WHERE   CURRENT OF cursor_sdep;
		
        FETCH NEXT FROM cursor_sdep INTO current_sdep;
    
	END LOOP;
    CLOSE cursor_sdep;
END;
$$ LANGUAGE PLPGSQL;

-- 
-- getAssetCategoryPropertyValue : 
-- 	récupère la valeur d'une catégorie à partir de la valeur key_ et l'id de la catégorie.
-- 	SELECT getAssetCategoryPropertyValue('code', 2)
--
CREATE OR REPLACE FUNCTION getAssetCategoryPropertyValue (
  propertyKey text,
  propertyCatId integer
)
RETURNS VARCHAR AS
$body$
declare
	propertyValue VARCHAR;
BEGIN

	SELECT acp.value
		FROM assetCategoryProperty acp
		WHERE acp.key_ = propertyKey
			AND acp.categoryid = propertyCatId INTO propertyValue;

	RETURN propertyValue;	
	
END;
$body$
LANGUAGE 'plpgsql';

--
-- Retourne la liste des labels d'une structure.
-- Paramètre : liste d'identifiant de région: 3002;3004
--
CREATE OR REPLACE FUNCTION getLabelStuctures (
	structureIds varchar
)
RETURNS VARCHAR AS
$body$
DECLARE 
	structures text;
	ids	integer[];
	currentId  integer;
	currentValue varchar;
BEGIN

	structures := '';	
	ids = regexp_split_to_array(structureIds, ';');
	
	FOREACH currentId IN ARRAY ids
	LOOP
	
		SELECT structure.name FROM organization_ structure
			WHERE structure.organizationid = currentId INTO currentValue;
		
		IF LENGTH (currentValue) > 0 THEN
			IF structures = '' THEN
				structures := currentValue;
			ELSE
				structures := structures || ';' ||  currentValue;
			END IF;
		END IF;
		
	END LOOP;
	
	RAISE NOTICE 'structures : %.', structures;
	
	RETURN structures;	

END;	
$body$
LANGUAGE 'plpgsql';


--
-- Retourne la liste des labels d'une région.
-- Paramètre : liste d'identifiant de région: 3002;3004
--
CREATE OR REPLACE FUNCTION getLabelsRegion (
	regionIds varchar
)
RETURNS VARCHAR AS
$body$
DECLARE 
	regions text;
	ids	integer[];
	currentId  integer;
	currentValue varchar;
BEGIN

	regions := '';	
	ids = regexp_split_to_array(regionIds, ';');
	FOREACH currentId IN ARRAY ids
	LOOP
		
		SELECT name FROM REGION as region 
			WHERE region.regionid = currentId INTO currentValue;
		
		IF LENGTH (currentValue) > 0 THEN
			IF regions = '' THEN
				regions := currentValue;
			ELSE
				regions := regions || ';' ||  currentValue;
			END IF;
		END IF;
		
	END LOOP;
	
	RAISE NOTICE 'regions : %.', regions;
	
	RETURN regions;	

END;	
$body$
LANGUAGE 'plpgsql';

--
-- Permet de retourner les valeurs d'une liste d'ids séparé par des ';'
-- 	en son équivalent littéral : liste des lables séparés par des ';'
--
CREATE OR REPLACE FUNCTION getLabelsCategory (
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

	newValue := '';
	currentValue := '';		
	ids = regexp_split_to_array(catIds, ';');
	-- RAISE NOTICE 'ids : %.', catIds;
	
	FOREACH currentId IN ARRAY ids
	LOOP
		select getAssetCategoryPropertyValue('code', currentId) into currentValue;
		IF newValue = '' THEN
			newValue := currentValue;
		ELSE
			newValue := newVAlue || ';' ||  currentValue;
		END IF;
	END LOOP;
	-- RAISE NOTICE 'categorie : %.', newValue;
	
	RETURN newValue;	
	
END;
$body$
LANGUAGE 'plpgsql';


