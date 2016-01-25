--
-- Selection des type de documents
--
SELECT name
FROM dlfileentrytype;

--
-- Requete V0.
SELECT dlfetype.name as type, dlfe.title, dlfe.description, dlfe.username as auteur
FROM dlfileentry dlfe
	INNER JOIN  dlfileentrytype dlfetype
	ON dlfe.fileentrytypeid = dlfetype.fileentrytypeid


--
-- Requete V1
SELECT dlfe.title, 
	CASE
		WHEN dlfetype.name ~~ '%Document de base%'::text THEN 'Document de base'::text
		WHEN dlfetype.name ~~ '%D-Document générique%'::text THEN 'D-Document générique'::text
		WHEN dlfetype.name ~~ '%D-CHSCT%'::text THEN 'D-CHSCT'::text
		WHEN dlfetype.name ~~ '%D-images%'::text THEN 'D-images'::text
		WHEN dlfetype.name ~~ '%D-Conseil Administration%'::text THEN 'D-Conseil Administration'::text
		WHEN dlfetype.name ~~ '%D-CODIR%'::text THEN 'D-CODIR'::text
		WHEN dlfetype.name ~~ '%D-Fiche de Poste%'::text THEN 'D-Fiche de Poste'::text
		WHEN dlfetype.name ~~ '%D-Reunion d''encadrement%'::text THEN 'D-Reunion d''encadrement'::text
		WHEN dlfetype.name ~~ '%D-Delegation Personel%'::text THEN 'D-Delegation Personel'::text		
		WHEN dlfetype.name ~~ '%D-FlashInfo%'::text THEN 'D-FlashInfo'::text
		WHEN dlfetype.name ~~ '%D-Universcience info%'::text THEN 'D-Universcience info'::text
		WHEN dlfetype.name ~~ '%D-Comité Programmation%'::text THEN 'D-Comité Programmation'::text	
		WHEN dlfetype.name ~~ '%D-Formulaire%'::text THEN 'D-Formulaire'::text
		WHEN dlfetype.name ~~ '%Contract%'::text THEN 'Contract'::text
		WHEN dlfetype.name ~~ '%Marketing Banner%'::text THEN 'Marketing Banner'::text			
		WHEN dlfetype.name ~~ '%Online Training%'::text THEN 'Online Training'::text
		WHEN dlfetype.name ~~ '%Sales Presentation%'::text THEN 'Sales Presentation'::text	
		ELSE NULL::text
	END AS structure, dlfe.description, dlfe.username as auteur
FROM dlfileentry dlfe
	INNER JOIN  dlfileentrytype dlfetype
	ON dlfe.fileentrytypeid = dlfetype.fileentrytypeid

--
-- Requete
SELECT dlfe.title, 
	CASE
		WHEN dlfetype.name like '%Document de base%' THEN 'Document de base'
		WHEN dlfetype.name like '%D-Document générique%' THEN 'D-Document générique'
		WHEN dlfetype.name like '%D-CHSCT%' THEN 'D-CHSCT'
		WHEN dlfetype.name like '%D-images%' THEN 'D-images'
		WHEN dlfetype.name like '%D-Conseil Administration%' THEN 'D-Conseil Administration'
		WHEN dlfetype.name like '%D-CODIR%' THEN 'D-CODIR'
		WHEN dlfetype.name like '%D-Fiche de Poste%' THEN 'D-Fiche de Poste'
		WHEN dlfetype.name like '%D-Reunion d''encadrement%' THEN 'D-Reunion d''encadrement'
		WHEN dlfetype.name like '%D-Delegation Personel%' THEN 'D-Delegation Personel'		
		WHEN dlfetype.name like '%D-FlashInfo%' THEN 'D-FlashInfo'
		WHEN dlfetype.name like '%D-Universcience info%' THEN 'D-Universcience info'
		WHEN dlfetype.name like '%D-Comité Programmation%' THEN 'D-Comité Programmation'	
		WHEN dlfetype.name like '%D-Formulaire%' THEN 'D-Formulaire'
		WHEN dlfetype.name like '%Contract%' THEN 'Contract'
		WHEN dlfetype.name like '%Marketing Banner%' THEN 'Marketing Banner'			
		WHEN dlfetype.name like '%Online Training%' THEN 'Online Training'
		WHEN dlfetype.name like '%Sales Presentation%' THEN 'Sales Presentation'	
		ELSE NULL
	END AS structure, dlfe.description, dlfe.username as auteur
FROM dlfileentry dlfe
	INNER JOIN  dlfileentrytype dlfetype
	ON dlfe.fileentrytypeid = dlfetype.fileentrytypeid
WHERE dlfetype.name like '%Document de base%'
	OR dlfetype.name like'%D-Document générique%'
	OR dlfetype.name like'%D-CHSCT%'
	OR dlfetype.name like'%D-images%'
	OR dlfetype.name like'%D-Conseil Administration%'
	OR dlfetype.name like'%D-CODIR%'
	OR dlfetype.name like'%D-Fiche de Poste%'
	OR dlfetype.name like'%D-Reunion d''encadrement%'
	OR dlfetype.name like'%D-Delegation Personel%'
	OR dlfetype.name like'%D-FlashInfo%'
	OR dlfetype.name like'%D-Universcience info%'
	OR dlfetype.name like'%D-Comité Programmation%'
	OR dlfetype.name like'%D-Formulaire%'
	OR dlfetype.name like'%Contract%'
	OR dlfetype.name like'%Marketing Banner%'
	OR dlfetype.name like'%Online Training%'	
	OR dlfetype.name like'%Sales Presentation%';	






