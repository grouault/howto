<%@ page import="com.citedessciences.struts.beans.AgendaBean" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.citedessciences.struts.beans.AgendaSectBean" %>
<%@ page import="com.citedessciences.struts.beans.AgendaEvBean" %>
<%@ page import="com.citedessciences.businesslogic.util.DateUtil" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.citedessciences.struts.util.RessourceFrontReader" %>
<%@ page import="java.util.Enumeration" %>
<%@ taglib uri="/WEB-INF/citedessciences.tld" prefix="csi" %>
<%@page import="com.citedessciences.struts.beans.LigneAgendaList"%>
<%@page import="com.citedessciences.struts.beans.LigneAgendaBean"%>
<%@page import="java.util.Date"%>
<%
	String userAgent = request.getHeader("user-agent");
	boolean isIE = false;
	if(userAgent.toUpperCase().indexOf("MSIE") != -1){
		isIE = true;
	}
	SimpleDateFormat DATE_EVT = new SimpleDateFormat("dd/MM/yyyy", Locale.FRENCH);
	
	AgendaBean agendaBean = (AgendaBean)request.getAttribute("agenda");
	Iterator itJour = agendaBean.iteratorJours();
	Iterator itSection = agendaBean.getListSection();
%>
<table class="agenda">
<%
	String[] tabJours;
	while (itSection.hasNext()) 
	{
		String nomSection = (String) itSection.next();
		AgendaSectBean section = (AgendaSectBean) agendaBean.getOrCreateSection(nomSection);
		
		LigneAgendaList lstLigneAgenda = section.getLigneAgendaList();
		lstLigneAgenda.sort();		
		lstLigneAgenda.fusionnerLignes();
		%>
		<tr>
		<td width="100%"><div style="border: 0px none ; height: 100%;">
		<div class="<%=section.getHTMLTitleStyle() %>"><%=section.getLibelle()%></div>
		<%
		for(Iterator iter = lstLigneAgenda.iterator(); iter.hasNext(); )
		{
			LigneAgendaBean ligneAgenda = (LigneAgendaBean)iter.next();
			tabJours = ligneAgenda.getJours();
			
			int width = 0;
			
			String idEvenementPrecedent = null;
			String idEvenement = null;
			
			itJour = agendaBean.iteratorJours();
			AgendaEvBean objAgendaEvBean = null;
			AgendaEvBean objAgendaEvBeanPrecedent = null;
			do 
			{
				Calendar calJour = (Calendar) itJour.next();			

				idEvenement = tabJours[calJour.get(Calendar.DAY_OF_WEEK)];

				// il y a un evenement ce jour 
				if (idEvenement != null)
				{
								
					// s'il s'agit d'un evenement différent du précédent, affichage de l'evenement précédent 
					if (idEvenementPrecedent != null)
					{
						if (!idEvenement.equals(idEvenementPrecedent))
						{
							objAgendaEvBeanPrecedent.setIndice_occurence(objAgendaEvBeanPrecedent.getIndice_occurence()+1);							

							if(!isIE)
								width--;
							%><csi:agendaEvenement width="<%=String.valueOf(width)%>" htmlStyleClassEv="<%=objAgendaEvBeanPrecedent.getHTMLStyleClass() %>"  displayDateDebut="<%=objAgendaEvBeanPrecedent.getDisplayDateDebut()%>" displayDateFin="<%=objAgendaEvBeanPrecedent.getDisplayDateFin(ligneAgenda)%>" libelleToDisplay="<%=objAgendaEvBeanPrecedent.getHTMLLibelleToDisplay(request, AgendaEvBean.AGENDA_SEMAINE)%>" /><%
							width = 120;
						}
						else
						{
							// meme evenement, on augmente la largeur de la case
							width = width + 120;
						}
			
					}
					else
					{
						// précédent null, augmentation de la largeur de la case
						width = width + 120;
					}
					
					objAgendaEvBean = ligneAgenda.getAgendaEvBean(idEvenement);
					idEvenementPrecedent = idEvenement;
					objAgendaEvBeanPrecedent = objAgendaEvBean;
				}
				else
				{ 
					// idEvenement == null, si width > 0, cela signifie qu'un evenement précédent est à afficher : 
					if (width > 0)
					{
						objAgendaEvBeanPrecedent.setIndice_occurence(objAgendaEvBeanPrecedent.getIndice_occurence()+1);							

						if(!isIE)
							width--;
							
						%><csi:agendaEvenement width="<%=String.valueOf(width)%>" htmlStyleClassEv="<%=objAgendaEvBeanPrecedent.getHTMLStyleClass() %>"  displayDateDebut="<%=objAgendaEvBeanPrecedent.getDisplayDateDebut()%>" displayDateFin="<%=objAgendaEvBeanPrecedent.getDisplayDateFin(ligneAgenda)%>" libelleToDisplay="<%=objAgendaEvBeanPrecedent.getHTMLLibelleToDisplay(request, AgendaEvBean.AGENDA_SEMAINE)%>" /><%
					}
					width = 120;
					if(!isIE)
						width--;
					// pas d'evenement à afficher, affichage d'une case vide 
					%>
					<div class="AgendaEvt agenda_empty" style="width:<%=width %>px;">&nbsp;</div>			
					<%
					width = 0;
					
					// réinitialisation des pointeurs evenement précédent 
					idEvenementPrecedent = null;
					objAgendaEvBeanPrecedent = null;
				}		
				
				// si un evenement a lieu le dernier jour de la semaine, on l'affiche 
				if (!itJour.hasNext() && width > 0)
				{
					objAgendaEvBean.setIndice_occurence(objAgendaEvBean.getIndice_occurence()+1);							
					
					if(!isIE)
						width--;
					%><csi:agendaEvenement width="<%=String.valueOf(width)%>" htmlStyleClassEv="<%=objAgendaEvBean.getHTMLStyleClass() %>"  displayDateDebut="<%=objAgendaEvBean.getDisplayDateDebut()%>" displayDateFin="<%=objAgendaEvBean.getDisplayDateFin(ligneAgenda)%>" libelleToDisplay="<%=objAgendaEvBean.getHTMLLibelleToDisplay(request, AgendaEvBean.AGENDA_SEMAINE)%>" /><%
				}
			}
			while (itJour.hasNext());
			%>
			</div>
			</td>
			</tr>
			<%
			// s'il reste des ligneAgendaBean dans la section, on crée la ligne du tableau pour la ligneAgendaBean suivante
			if (iter.hasNext())
			{
				%>
				   <tr>
				    <td><div style="border: 0px none ; height: 100%;">
		      		<div class="agenda_titre_empty"></div>
		      	<%				
			}
			
		}
	}
	%>
</div>
</td>
</tr>
</table>