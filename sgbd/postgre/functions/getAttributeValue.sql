-- 
-- getPropertyValue : return set
-- SELECT * FROM getpropertyvalue('code', 1) AS (property_value varchar);
CREATE OR REPLACE FUNCTION getpropertyvalue (
  categorylabel varchar,
  categoryid integer
)
RETURNS setof record AS
$body$
declare
	rec record;
BEGIN

	FOR rec IN	
		SELECT property_value 
			FROM category_property
			WHERE property_label = categoryLabel
				AND category_id = categoryId
    LOOP
		RETURN next rec;
    END LOOP;
	RETURN;	
	
END;
$body$
LANGUAGE 'plpgsql';

-- 
-- getPropertyValue : return varchar en récupérant un record typé
-- SELECT * from getpropertyvalue('code', 2)
-- SELECT getpropertyvalue('code', 2)
CREATE OR REPLACE FUNCTION getpropertyvalue (
  categorylabel text,
  categoryid integer
)
RETURNS VARCHAR AS
$body$
declare
	property    category_property%ROWTYPE;
BEGIN

	SELECT * 
		FROM category_property
		WHERE property_label = categoryLabel
			AND category_id = categoryId INTO property;

	RETURN property.property_value;	
	
END;
$body$
LANGUAGE 'plpgsql';

-- 
-- getPropertyValue : récupération de la valeur.
-- SELECT * from getpropertyvalue('code', 2)
-- SELECT getpropertyvalue('code', 2)
CREATE OR REPLACE FUNCTION getpropertyvalue (
  categorylabel text,
  categoryid integer
)
RETURNS VARCHAR AS
$body$
declare
	propertyValue VARCHAR;
BEGIN

	SELECT property_value
		FROM category_property
		WHERE property_label = categoryLabel
			AND category_id = categoryId INTO propertyValue;

	RETURN propertyValue;	
	
END;
$body$
LANGUAGE 'plpgsql';