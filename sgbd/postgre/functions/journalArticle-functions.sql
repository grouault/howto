-- 
-- getJALieu
-- SELECT getJALieu(93874,417372)
--
DROP FUNCTION getJALieu(bigint,bigint);
CREATE OR REPLACE FUNCTION getJALieu (
	journalarticle_Id bigint,
	vocabulary_Id bigint
)
RETURNS VARCHAR AS
$body$
declare
	currentValue	text;
BEGIN

	SELECT ac.name
		FROM  assetentry ae 
		INNER JOIN assetentries_assetcategories aeac
			ON ae.entryid = aeac.entryid 
		INNER JOIN assetcategory ac
			on aeac.categoryid = ac.categoryid
		WHERE ae.classpk = journalarticle_Id
		and ac.vocabularyid = vocabulary_Id INTO currentValue;
	
	RETURN currentValue;	
	
END;
$body$
LANGUAGE 'plpgsql';

--
-- getJAThematique
-- SELECT getJAThematique(93874,402699)
--
CREATE OR REPLACE FUNCTION getJAThematique (
	journalarticle_Id bigint,
	vocabulary_Id bigint
)
RETURNS VARCHAR AS
$body$
declare
	thematiques	text;
	current_category text;
	cursor_category CURSOR FOR SELECT ac.name
		FROM  assetentry ae 
		INNER JOIN assetentries_assetcategories aeac
			ON ae.entryid = aeac.entryid 
		INNER JOIN assetcategory ac
			on aeac.categoryid = ac.categoryid
		WHERE ae.classpk = journalarticle_Id
		and ac.vocabularyid = vocabulary_Id;
	
BEGIN
	
	thematiques := '';
	OPEN cursor_category;
    FETCH FIRST FROM cursor_category INTO current_category;
    WHILE FOUND = TRUE LOOP
    	IF thematiques = '' THEN
    		thematiques = current_category;
    	ELSE
    		thematiques := thematiques || ',' ||  current_category;
    	END IF;
    	FETCH NEXT FROM cursor_category INTO current_category;
	END LOOP;
    CLOSE cursor_category;
	RETURN thematiques;	
	
END;
$body$
LANGUAGE 'plpgsql';