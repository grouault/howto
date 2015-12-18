# Requête globale
##
SELECT 2, fiche.num_seq_fichedt AS idfiche, fiche.titre_court, d.date_debut,
       d.date_fin, type_ope.libelle_type_operation, fiche.statut,
       type_ope.code_type_operation, debut_fin.date_fin_derniere_occurence,
       debut_fin.date_debut_premiere_occurence
  FROM fiche_dt fiche,
       fiche_dt_date resdate,
       ref_type_operation type_ope,
       date_evenement d,
(SELECT fiche_dt.num_seq_fichedt AS id_fiche,
         MAX (date_evenement.date_fin) AS date_fin_derniere_occurence,
         MIN (date_evenement.date_debut) AS date_debut_premiere_occurence
    FROM fiche_dt, fiche_dt_date, date_evenement
    WHERE fiche_dt.num_seq_fichedt = fiche_dt_date.idfiche
     AND fiche_dt_date.iddate = date_evenement.numseqdate
GROUP BY fiche_dt.num_seq_fichedt) debut_fin
 WHERE fiche.num_seq_fichedt = resdate.idfiche
   AND d.numseqdate = resdate.iddate
   AND fiche.statut != 'historique'
   AND debut_fin.id_fiche=idfiche
   AND fiche.code_type_operation = type_ope.code_type_operation
   AND (   d.date_debut BETWEEN TO_DATE ('01/12/2009', 'DD/MM/YYYY')
                            AND TO_DATE ('31/12/2009', 'DD/MM/YYYY')
        OR d.date_fin BETWEEN TO_DATE ('01/12/2009', 'DD/MM/YYYY')
                          AND TO_DATE ('31/12/2009', 'DD/MM/YYYY')
        OR TO_DATE ('01/12/2009', 'DD/MM/YYYY') BETWEEN d.date_debut
                                                    AND d.date_fin
        OR TO_DATE ('31/12/2009', 'DD/MM/YYYY') BETWEEN d.date_debut
                                                    AND d.date_fin
       )
       
       
     
     
# Requete de test.
##       
SELECT 2, fiche.num_seq_fichedt AS idfiche, fiche.titre_court, d.date_debut,
       d.date_fin, type_ope.libelle_type_operation, fiche.statut,
       type_ope.code_type_operation
  FROM fiche_dt fiche,
       fiche_dt_date resdate,
       ref_type_operation type_ope,
       date_evenement d
 WHERE fiche.num_seq_fichedt = resdate.idfiche
   AND d.numseqdate = resdate.iddate
   AND fiche.statut != 'historique'
   AND fiche.code_type_operation = type_ope.code_type_operation
   AND (   d.date_debut BETWEEN TO_DATE ('07/12/2009', 'DD/MM/YYYY')
                            AND TO_DATE ('13/12/2009', 'DD/MM/YYYY')
        OR d.date_fin BETWEEN TO_DATE ('07/12/2009', 'DD/MM/YYYY')
                          AND TO_DATE ('13/12/2009', 'DD/MM/YYYY')
        OR TO_DATE ('07/12/2009', 'DD/MM/YYYY') BETWEEN d.date_debut
                                                    AND d.date_fin
        OR TO_DATE ('13/12/2009', 'DD/MM/YYYY') BETWEEN d.date_debut
                                                    AND d.date_fin
       )         
    
# Requete intermediaire
##   
(SELECT fiche_dt.num_seq_fichedt AS id_fiche,
         MAX (date_evenement.date_fin) AS date_fin_derniere_occurence,
         MIN
            (date_evenement.date_debut
            ) AS date_debut_premiere_occurence
    FROM fiche_dt, fiche_dt_date, date_evenement
    WHERE fiche_dt.num_seq_fichedt = fiche_dt_date.idfiche
     AND fiche_dt_date.iddate = date_evenement.numseqdate
GROUP BY fiche_dt.num_seq_fichedt)

# Requetes imbriquées
##
SELECT 2, fiche.num_seq_fichedt AS idfiche, fiche.titre_court, d.date_debut,
       d.date_fin, type_ope.libelle_type_operation, fiche.statut,
       type_ope.code_type_operation
  FROM fiche_dt fiche,
       fiche_dt_date resdate,
       ref_type_operation type_ope,
       date_evenement d,
       (SELECT fiche_dt.num_seq_fichedt AS id_fiche,
         MAX (date_evenement.date_fin) AS date_fin_derniere_occurence,
         MIN
            (date_evenement.date_debut
            ) AS date_debut_premiere_occurence
		    FROM fiche_dt, fiche_dt_date, date_evenement
		    WHERE fiche_dt.num_seq_fichedt = fiche_dt_date.idfiche
		     AND fiche_dt_date.iddate = date_evenement.numseqdate
				GROUP BY fiche_dt.num_seq_fichedt) debut_fin
 WHERE fiche.num_seq_fichedt = resdate.idfiche
   AND d.numseqdate = resdate.iddate
   AND fiche.statut != 'historique'
   AND debut_fin.id_fiche = idfiche
   AND fiche.code_type_operation = type_ope.code_type_operation
   AND (   d.date_debut BETWEEN TO_DATE ('07/12/2009', 'DD/MM/YYYY')
                            AND TO_DATE ('13/12/2009', 'DD/MM/YYYY')
        OR d.date_fin BETWEEN TO_DATE ('07/12/2009', 'DD/MM/YYYY')
                          AND TO_DATE ('13/12/2009', 'DD/MM/YYYY')
        OR TO_DATE ('07/12/2009', 'DD/MM/YYYY') BETWEEN d.date_debut
                                                    AND d.date_fin
        OR TO_DATE ('13/12/2009', 'DD/MM/YYYY') BETWEEN d.date_debut
                                                    AND d.date_fin
       )