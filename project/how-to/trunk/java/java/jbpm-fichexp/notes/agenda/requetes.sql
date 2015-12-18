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

--
-- Requete Informations importantes
--
select date_debut, date_fin, libelle_information, code, numseqinfimp 
from information_importante i  
where ( 
	i.DATE_DEBUT between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
	or i.DATE_FIN between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
) and i.site_actif IN ('11','10') 
union 
select date_debut, date_fin, libelle_information,code, numseqinfimp  
from information_importante i  
where ( 
	TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') between i.DATE_DEBUT and i.DATE_FIN  
	or TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') between i.DATE_DEBUT and i.DATE_FIN 
) and i.site_actif IN ('11','10')

--
-- Evenement exceptionnel
--
select libelle_evenement, date_debut, date_fin, numseqevtxcp 
from evenement_exceptionnel e 
where ( 
	TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') between e.DATE_DEBUT and e.DATE_FIN 
	or TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') between e.DATE_DEBUT and e.DATE_FIN 
) and e.site_actif IN ('11','10') 
union  
select libelle_evenement, date_debut, date_fin, numseqevtxcp 
from evenement_exceptionnel e  
where ( 
	e.DATE_DEBUT between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI')  
	or e.DATE_FIN between TO_DATE('19/11/2012 00:00','DD/MM/YYYY HH24:MI') and TO_DATE('25/11/2012 00:00','DD/MM/YYYY HH24:MI') 
) 
and e.site_actif IN ('11','10')