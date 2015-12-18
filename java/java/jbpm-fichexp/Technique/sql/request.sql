--
-- Recherche des fiches de reservations.
--
Select fr.numseqficres, fr.titre, fr.id_chef_projet, fr.date_confirmation
FROM fiche_reservation fr
where fr.date_confirmation 
	between TO_DATE('30/01/2013 00:00','DD/MM/YYYY HH24:MI')
	and TO_DATE('06/02/2013 00:00','DD/MM/YYYY HH24:MI');


--
-- Requete Astreinte Agenda.
--
select securite, date_debut, date_fin, directeur, responsable, numseqast 
from astreinte a 
where (  
TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') between a.DATE_DEBUT and a.DATE_FIN 
or 
TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') between a.DATE_DEBUT and a.DATE_FIN 
) 
and site_actif IN ('11','01') 
union 
select securite, date_debut, date_fin, directeur, responsable, numseqast 
from astreinte a 
where ( 
a.DATE_DEBUT between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
or a.DATE_FIN between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
)
and site_actif IN ('11','01')