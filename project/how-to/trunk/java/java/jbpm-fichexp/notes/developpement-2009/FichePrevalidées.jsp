tache1
------


# Fiche de r�servations
####


Affichage des fiches de r�servations pr�valid�es:		
		
		<form-bean name="ListeFicheRPrevaliderForm" type="com.citedessciences.struts.forms.ListForm" />
		
		<action path="/FicheRPrevalidees"
			type="com.citedessciences.struts.actions.ListeFicheRPreValidees"
			name="ListeFicheRPrevaliderForm"
			scope="session">
			<forward name="success" path=".reservation_Prevalidees" />
		</action>	
		
		<definition name=".reservation_Prevalidees" extends=".listfiche2_0">
			<put name="title" value="title.reservations_prevalidees" />
			<put name="titreContent" value="titreContent.reservations_prevalidees" />		
		</definition>
		
		
title.reservations_prevalidees=test1-tma
titreContent.reservations_prevalidees=test2-tma


Action cr��:
------------
com.citedessciences.struts.actions.ListeFicheRPreValidees

/menu.xml
---------
modification du r�le 6 comme dans le cahier des charges.


JSP touch�:
-----------
jsp/reservation/liste_fiche.jsp

R�le pour test:
---------------
Test� avec un chef de projet ayant l'id: 500 - attrributino du role 6.

# Fiche d'exploitations
###

Affichage des fiches d'exploitations pr�valid�es:		
		
		<form-bean name="ListeFicheEPrevaliderForm" type="com.citedessciences.struts.forms.ListForm" />
		
		<action path="/FicheEPrevalidees"
			type="com.citedessciences.struts.actions.ListeFicheEPreValidees"
			name="ListeFicheEPrevaliderForm"
			scope="session">
			<forward name="success" path=".exploitation_Prevalidees" />
		</action>	
		
		<definition name=".exploitation_Prevalidees" extends=".listfiche2_0">
			<put name="title" value="title.exploitation_Prevalidees" />
			<put name="titreContent" value="titreContent.exploitation_Prevalidees" />		
		</definition>


title.exploitation_Prevalidees=Toutes les fiches d'exploitation
titreContent.exploitation_Prevalidees=Toutes les fiches d'exploitation pr�valid�es

