
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.citedessciences.struts.beans.AgendaBean" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Locale" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/citedessciences.tld" prefix="csi"%>
<script>
	
	function openPopup(page,nom,options)
	{
		window.open(page,nom,options);
	}
	function imprimerDetail() {
		var response = confirm("La cité de sciences et de l'indsutrie respecte la charte du developpement durable. Etes-vous sûr de vouloir imprimer ?");
		if (response==true){
			openPopup('AgendaSemaine.do?methodToCall=imprimerDetail&impressionAgenda=semaine&typeFiche=-1','Test','resizable=yes, location=no, width=800, height=600, menubar=no, status=no, scrollbars=no');
		}
	}
</script>
<table class="agenda">
<%
	String userAgent = request.getHeader("user-agent");
	boolean isIE = false;
	if(userAgent.toUpperCase().indexOf("MSIE") != -1){
		isIE = true;
	}
	SimpleDateFormat COLJOUR = new SimpleDateFormat("EEEEE dd", Locale.FRENCH);
	SimpleDateFormat TITJOUR = new SimpleDateFormat("dd MMMMM yyyy", Locale.FRENCH);
	
	AgendaBean agendaBean = (AgendaBean)request.getAttribute("agenda");
	Iterator itJour = agendaBean.iteratorJours();
%>

	<tr>
		<td style="text-align:left;"><b>SEMAINE DU <%=TITJOUR.format(agendaBean.getDebut())%> AU <%=TITJOUR.format(agendaBean.getFin())%></b></td>
		<td align="right">
			<html:link href="javascript:openPopup('AgendaSemaine.do?methodToCall=imprimer&impressionAgenda=semaine&typeFiche=-1','Test','resizable=yes, location=no, width=800, height=600, menubar=no, status=no, scrollbars=no');">
				<csi:Image imageName="bouton_Imprimer_enable.gif" styleClass="boutonhaut" />
			</html:link>	
			<html:link href="javascript:imprimerDetail();">
				<csi:Image imageName="bouton_imprimer_details.gif" styleClass="boutonhaut"/>
			</html:link>
		</td>
	</tr>
	<tr>
		<td colspan="2"><div class="agenda_titre_haut_empty">&nbsp;</div>	
		<%
		int width = 120;
		if(!isIE){
			width--;
		}
		while (itJour.hasNext()) {
			Calendar c = (Calendar) itJour.next();
		%>
			<div class="agenda_titre_haut" style="width:<%= width %>px;"><%=COLJOUR.format(c.getTime())%></div>
		<%	
		}			
		%>
		</td>
	</tr>
</table>