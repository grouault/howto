---------------------
-- Tables de jointures :
-- 1- fiche_exploitation fiche
-- 2- ficheexp_date resdate
-- 3- ref_type_operation type_ope
-- 4- date_evenement d
-- 5- Table construite dynamiquement a l'execution :
--	   qui permet pour une fiche de remonter la premiere et la derniere occurence de la fiche.
---------------------
select 4, fiche.num_seq_ficpalais as idfiche, fiche.TITRE_COURT, d.date_debut, d.date_fin, type_ope.LIBELLE_TYPE_OPERATION, fiche.statut, type_ope.CODE_TYPE_OPERATION, DEBUT_FIN.date_fin_derniere_occurence, DEBUT_FIN.date_debut_premiere_occurence        
from fiche_palais fiche, fiche_palais_date resdate, ref_type_operation type_ope, date_evenement d,    	 
	(SELECT fiche_palais.num_seq_ficpalais as id_fiche, MAX(date_evenement.date_fin) AS date_fin_derniere_occurence, MIN(date_evenement.date_debut) AS date_debut_premiere_occurence        
     FROM fiche_palais, fiche_palais_date, date_evenement       
     WHERE fiche_palais.num_seq_ficpalais = fiche_palais_date.idfiche         
     AND fiche_palais_date.iddate = date_evenement.numseqdate  
     GROUP BY fiche_palais.num_seq_ficpalais) debut_fin
where fiche.num_seq_ficpalais = resdate.IDFICHE 	 
and d.NUMSEQDATE = resdate.IDDATE 
and(
 d.DATE_DEBUT between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
 or d.DATE_FIN between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
 or TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') between d.DATE_DEBUT and d.DATE_FIN or TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') between d.DATE_DEBUT and d.DATE_FIN
)
and fiche.statut != 'historique'
and fiche.CODE_TYPE_OPERATION = type_ope.CODE_TYPE_OPERATION
and debut_fin.id_fiche = idfiche
/* query fiche exploitation valide. */
 union all 
 select 4, fiche.id_fiche_pal_valide as idfiche, fiche.TITRE_COURT, d.date_debut, d.date_fin, type_ope.LIBELLE_TYPE_OPERATION_VALIDE, fiche.statut,-1, DEBUT_FIN.date_fin_derniere_occurence, DEBUT_FIN.date_debut_premiere_occurence        
 from fiche_palais_valide fiche, fiche_palais_date_valide resdate, type_operation_valide type_ope, date_evenement_valide d,        
	(SELECT fiche_palais_valide.id_fiche_pal_valide AS id_fiche, MAX (date_evenement_valide.date_fin) AS date_fin_derniere_occurence, MIN (date_evenement_valide.date_debut) AS date_debut_premiere_occurence         
	  FROM fiche_palais_valide, fiche_palais_date_valide, date_evenement_valide        
	  WHERE fiche_palais_valide.id_fiche_pal_valide = fiche_palais_date_valide.idfiche          
	    AND fiche_palais_date_valide.iddate = date_evenement_valide.iddate_evt_valide     
		GROUP BY fiche_palais_valide.id_fiche_pal_valide) debut_fin  
where fiche.id_fiche_pal_valide = resdate.IDFICHE 
and d.IDDATE_EVT_VALIDE = resdate.IDDATE 
and fiche.statut != 'historique' 
and fiche.CODE_TYPE_OPERATION = type_ope.CODE_TYPE_OPERATION_VALIDE 
and debut_fin.id_fiche = idfiche  
and (
	d.DATE_DEBUT between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
 or d.DATE_FIN between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
 or TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') between d.DATE_DEBUT and d.DATE_FIN 
 or TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') between d.DATE_DEBUT and d.DATE_FIN
 );  
-----------------------	 
-- Condition de jointure :
-----------------------
-- on ne retient que le fiches qui sont dans le bon creneau de dates.
where fiche_palais.num_seq_ficpalais = resdate.IDFICHE 
and d.NUMSEQDATE = resdate.IDDATE 
and (
	d.DATE_DEBUT between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
 or d.DATE_FIN between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
 or TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') between d.DATE_DEBUT and d.DATE_FIN or TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') between d.DATE_DEBUT and d.DATE_FIN
 ) 
-- on recupere toutes les fiches qui n'ont pas le statut 'historique'
and fiche.statut != 'historique' 
-- recuperation du code_type_operation de la fiche.
and fiche.CODE_TYPE_OPERATION = type_ope.CODE_TYPE_OPERATION 
-- recuperation de la date de premiere occurence de la fiche et 
-- recuperation de la date de derniere occurence de la fiche
and debut_fin.id_fiche = idfiche  


----------------------------------------------------
-- Requete de selection preparatoire de selection --
-- de la premiere et dernier occurence des dates
-- evnements pour les fiches d exploitation 			
----------------------------------------------------
SELECT fiche_palais.num_seq_ficpalais, MAX(date_evenement.date_fin) AS date_fin_derniere_occurence, MIN(date_evenement.date_debut) AS date_debut_premiere_occurence        
     FROM fiche_palais, fiche_palais_date, date_evenement       
     WHERE fiche_palais.num_seq_ficpalais = fiche_palais_date.idfiche         
     AND fiche_palais_date.iddate = date_evenement.numseqdate  
     GROUP BY fiche_palais.num_seq_ficpalais;
     
-- selection des date_evenements pour une fiche.     
SELECT fiche_palais.num_seq_ficpalais, MAX(date_evenement.date_fin) AS date_fin_derniere_occurence, MIN(date_evenement.date_debut) AS date_debut_premiere_occurence        
     FROM fiche_palais, fiche_palais_date, date_evenement       
     WHERE fiche_palais.num_seq_ficpalais = fiche_palais_date.idfiche         
     AND fiche_palais_date.iddate = date_evenement.numseqdate  
     AND fiche_palais.num_seq_ficpalais IN (141581)
     GROUP BY fiche_palais.num_seq_ficpalais;

-- selection des date_evnements : min et max. pour une fiche
SELECT fiche_palais.num_seq_ficpalais, date_evenement.date_fin AS date_fin_derniere_occurence, date_evenement.date_debut AS date_debut_premiere_occurence        
     FROM fiche_palais, fiche_palais_date, date_evenement       
     WHERE fiche_palais.num_seq_ficpalais = fiche_palais_date.idfiche         
     AND fiche_palais_date.iddate = date_evenement.numseqdate  
     AND fiche_palais.num_seq_ficpalais IN (141581)
     ORDER BY date_fin_derniere_occurence desc;
     /* ORDER BY date_debut_premiere_occurence asc; */
       
--  selection des dates evements des fiches exploit. tries suivant le numero de la fiche.   
SELECT fiche_palais.num_seq_ficpalais, date_evenement.date_fin AS date_fin_derniere_occurence, date_evenement.date_debut AS date_debut_premiere_occurence        
     FROM fiche_palais, fiche_palais_date, date_evenement       
     WHERE fiche_palais.num_seq_ficpalais = fiche_palais_date.idfiche         
     AND fiche_palais_date.iddate = date_evenement.numseqdate  
     ORDER BY fiche_palais.num_seq_ficpalais

 
