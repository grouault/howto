--
-- View vw_documents
-- 
DROP VIEW vw_documents; 
CREATE OR REPLACE VIEW vw_documents AS 

SELECT dlfe.fileentryid, dlfe.groupid, dlfe.companyid, dlfe.title, dlfe.modifieddate, dlfe.createdate, dlf."name",
       CASE
          WHEN dlfetype.name LIKE '%Document de base%'
          THEN
             'Document de base'
          WHEN dlfetype.name LIKE '%D-Document générique%'
          THEN
             'D-Document générique'
          WHEN dlfetype.name LIKE '%D-CHSCT%'
          THEN
             'D-CHSCT'
          WHEN dlfetype.name LIKE '%D-images%'
          THEN
             'D-images'
          WHEN dlfetype.name LIKE '%D-Conseil Administration%'
          THEN
             'D-Conseil Administration'
          WHEN dlfetype.name LIKE '%D-CODIR%'
          THEN
             'D-CODIR'
          WHEN dlfetype.name LIKE '%D-Fiche de Poste%'
          THEN
             'D-Fiche de Poste'
          WHEN dlfetype.name LIKE '%D-Reunion d''encadrement%'
          THEN
             'D-Reunion d''encadrement'
          WHEN dlfetype.name LIKE '%D-Delegation Personel%'
          THEN
             'D-Delegation Personel'
          WHEN dlfetype.name LIKE '%D-FlashInfo%'
          THEN
             'D-FlashInfo'
          WHEN dlfetype.name LIKE '%D-Universcience info%'
          THEN
             'D-Universcience info'
          WHEN dlfetype.name LIKE '%D-Comité Programmation%'
          THEN
             'D-Comité Programmation'
          WHEN dlfetype.name LIKE '%D-Formulaire%'
          THEN
             'D-Formulaire'
          WHEN dlfetype.name LIKE '%Contract%'
          THEN
             'Contract'
          WHEN dlfetype.name LIKE '%Marketing Banner%'
          THEN
             'Marketing Banner'
          WHEN dlfetype.name LIKE '%Online Training%'
          THEN
             'Online Training'
          WHEN dlfetype.name LIKE '%Sales Presentation%'
          THEN
             'Sales Presentation'
          ELSE
             NULL
       END
          AS type,
       dlfe.description,
       dlfe.username AS username,
	   dlfe.extension,
	   dlfe.version,
	   dlfe.size_,
	   concat('/documents/', dlfe.groupid, '/', dlfe.uuid_, '?version=', dlfe.version) as url,
	   ddmc.xml as metadatas
 FROM dlfileentry dlfe
 	JOIN dlfileentrytype dlfetype ON dlfe.fileentrytypeid = dlfetype.fileentrytypeid
	JOIN dlfolder dlf ON dlfe.folderid = dlf.folderid
	JOIN dlfileentrymetadata dlfemtd ON dlfemtd.fileentryid = dlfe.fileentryid
		AND dlfemtd.fileentrytypeid = dlfe.fileentrytypeid
	JOIN dlfileversion dlfv ON dlfe.version=dlfv.version
		AND dlfv.fileversionid = dlfemtd.fileversionid
	JOIN ddmcontent ddmc ON dlfemtd.ddmstorageid = ddmc.contentid
 WHERE dlfetype.name LIKE '%Document de base%'
       OR dlfetype.name LIKE '%D-Document générique%'
       OR dlfetype.name LIKE '%D-CHSCT%'
       OR dlfetype.name LIKE '%D-images%'
       OR dlfetype.name LIKE '%D-Conseil Administration%'
       OR dlfetype.name LIKE '%D-CODIR%'
       OR dlfetype.name LIKE '%D-Fiche de Poste%'
       OR dlfetype.name LIKE '%D-Reunion d''encadrement%'
       OR dlfetype.name LIKE '%D-Delegation Personel%'
       OR dlfetype.name LIKE '%D-FlashInfo%'
       OR dlfetype.name LIKE '%D-Universcience info%'
       OR dlfetype.name LIKE '%D-Comité Programmation%'
       OR dlfetype.name LIKE '%D-Formulaire%'
       OR dlfetype.name LIKE '%Contract%'
       OR dlfetype.name LIKE '%Marketing Banner%'
       OR dlfetype.name LIKE '%Online Training%'
       OR dlfetype.name LIKE '%Sales Presentation%'
ORDER  BY dlfe.modifieddate DESC;
	
ALTER TABLE vw_documents OWNER TO liferay;	