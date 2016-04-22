--
-- View: vw_contenus
-- View : vw_journalarticle_categories
-- Necessite la présence de la vue 'vw_journalarticle_categories'
--
drop view if exists vw_contenus;
drop view if exists vw_journalarticle_categories;
create view vw_journalarticle_categories as
	select max(ja.version) as version, ja.articleid as journalarticle_id, getJALieu(ja.resourceprimkey, 417372) as lieu, getJAThematique(ja.resourceprimkey, 402699) as thematiques
		from journalarticle ja
		GROUP BY ja.articleid,ja.resourceprimkey;
	
CREATE OR REPLACE VIEW vw_contenus AS 
         SELECT DISTINCT 'id='::text || ae.classpk AS resourceurl, ja.articleid, 
            ja.uuid_, ja.companyid, ja.groupid, 
            replace(ja.title, '<?xml version=''1.0'' encoding=''UTF-8''?>'::text, ''::text) AS title, 
            ja.urltitle, 
            replace(ja.content, '<?xml version=''1.0''?>', '<?xml version=''1.0'' encoding=''UTF-8''?>') AS content,
            ja.structureid, 
                CASE
                    WHEN struct.name ~~ '%C-Breves%'::text THEN 'C-Breves'::text
                    WHEN struct.name ~~ '%C-Article%'::text THEN 'C-Article'::text
                    WHEN struct.name ~~ '%C-Diaporama%'::text THEN 'C-Diaporama'::text
                    WHEN struct.name ~~ '%C-Texte Defilant%'::text THEN 'C-Texte Defilant'::text
                    WHEN struct.name ~~ '%C-FlashInfo%'::text THEN 'C-FlashInfo'::text
                    WHEN struct.name ~~ '%C-Formulaire%'::text THEN 'C-Formulaire'::text
                    ELSE NULL::text
                END AS structure, 
            ja.templateid, ja.description, ja.createdate, ja.modifieddate, 
            ja.username, ja.userid, ja.statusbyuserid, ja.statusbyusername, 
            ja.statusdate, ja.version, 
                CASE
                    WHEN jacs.privatelayout THEN ('/group'::text || grp.friendlyurl::text) || l.friendlyurl::text
                    ELSE ('/web'::text || grp.friendlyurl::text) || l.friendlyurl::text
                END AS url,
            vwjac.lieu, 
            vwjac.thematiques
           FROM journalarticle ja
   JOIN assetentry ae ON ae.classpk = ja.resourceprimkey
   JOIN ddmstructure struct ON ja.structureid::text = struct.structurekey::text
   JOIN journalcontentsearch jacs ON ja.articleid::text = jacs.articleid::text
   JOIN layout l ON jacs.layoutid = l.layoutid
   JOIN group_ grp ON grp.groupid = l.groupid
   JOIN vw_journalarticle_categories vwjac ON ja.articleid = vwjac.journalarticle_id
  WHERE l.type_::text = 'portlet'::text AND l.groupid = jacs.groupid AND ja.status = 0 AND (ja.id_ IN ( SELECT breves.id_
   FROM ( SELECT ja.resourceprimkey, max(ja.id_) AS id_, max(ja.version) AS max
           FROM journalarticle ja
      JOIN ddmstructure dstr ON dstr.structurekey::text = ja.structureid::text
     WHERE (dstr.name ~~ '%C-Breves%'::text OR dstr.name ~~ '%C-Article%'::text OR dstr.name ~~ '%C-Diaporama%'::text OR dstr.name ~~ 'C-Texte Defilant'::text OR dstr.name ~~ '%C-FlashInfo%'::text OR dstr.name ~~ 'C-Formulaire'::text) AND ja.status = 0
     GROUP BY ja.resourceprimkey) breves))
UNION 
         SELECT DISTINCT 'id='::text || ae.classpk AS resourceurl, ja.articleid, 
            ja.uuid_, ja.companyid, ja.groupid, 
            replace(ja.content, '<?xml version=''1.0''?>', '<?xml version=''1.0'' encoding=''UTF-8''?>') AS content,
            ja.urltitle, ja.content, ja.structureid, 
                CASE
                    WHEN struct.name ~~ '%C-Breves%'::text THEN 'C-Breves'::text
                    WHEN struct.name ~~ '%C-Article%'::text THEN 'C-Article'::text
                    WHEN struct.name ~~ '%C-Diaporama%'::text THEN 'C-Diaporama'::text
                    WHEN struct.name ~~ '%C-Texte Defilant%'::text THEN 'C-Texte Defilant'::text
                    WHEN struct.name ~~ '%C-FlashInfo%'::text THEN 'C-FlashInfo'::text
                    WHEN struct.name ~~ '%C-Formulaire%'::text THEN 'C-Formulaire'::text
                    ELSE NULL::text
                END AS structure, 
            ja.templateid, ja.description, ja.createdate, ja.modifieddate, 
            ja.username, ja.userid, ja.statusbyuserid, ja.statusbyusername, 
            ja.statusdate, ja.version, 
                CASE
                    WHEN struct.name ~~ '%C-Breves%'::text THEN '/group/breves/changeme'::text
                    WHEN struct.name ~~ '%C-Article%'::text THEN '/group/articles/changeme'::text
                    WHEN struct.name ~~ '%C-Diaporama%'::text THEN '/group/diaporama/changeme'::text
                    WHEN struct.name ~~ '%C-Texte Defilant%'::text THEN '/group/textedefilant/changeme'::text
                    WHEN struct.name ~~ '%C-FlashInfo%'::text THEN '/group/flashes/changeme'::text
                    WHEN struct.name ~~ '%C-Formulaire%'::text THEN '/group/formulaires/changeme'::text
                    ELSE NULL::text
                END AS url,
            vwjac.lieu, 
            vwjac.thematiques
           FROM journalarticle ja
      JOIN assetentry ae ON ae.classpk = ja.resourceprimkey
   JOIN ddmstructure struct ON ja.structureid::text = struct.structurekey::text
   JOIN vw_journalarticle_categories vwjac ON ja.articleid = vwjac.journalarticle_id
  WHERE ja.status = 0 AND (ja.id_ IN ( SELECT breves.id_
         FROM ( SELECT ja.resourceprimkey, max(ja.id_) AS id_, 
                  max(ja.version) AS max
                 FROM journalarticle ja
            JOIN ddmstructure dstr ON dstr.structurekey::text = ja.structureid::text
           WHERE (dstr.name ~~ '%C-Breves%'::text OR dstr.name ~~ '%C-Article%'::text OR dstr.name ~~ '%C-Diaporama%'::text OR dstr.name ~~ 'C-Texte Defilant'::text OR dstr.name ~~ '%C-FlashInfo%'::text OR dstr.name ~~ 'C-Formulaire'::text) AND ja.status = 0
           GROUP BY ja.resourceprimkey) breves)) AND NOT (ja.articleid::text IN ( SELECT DISTINCT jacs.articleid
         FROM journalcontentsearch jacs));

ALTER TABLE vw_contenus
  OWNER TO liferay;

